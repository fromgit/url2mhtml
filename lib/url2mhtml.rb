require 'rubygems'
require 'mechanize'
require 'tmail'

class Url2mhtml
  VERSION = '0.0.2'
  ContentInfo=Struct.new(:uri,:type,:body,:is_root,:title)

  def self.get_agent
    user_agent_alias ='Windows IE 6'
    agent = WWW::Mechanize.new
    agent.user_agent_alias =user_agent_alias
    agent
  end

  def self.get_content(uri,is_root)
    got_content = get_agent.get(uri)
    type=got_content.response['content-type']
    body=got_content.body
     
    title= ( is_root && /html/.match(type) ) ? got_content.title : 'no title'
     
    content_info=ContentInfo.new(uri,type,body,is_root,title)
    return content_info,got_content
  end

  def self.get_contents(uri,is_root,content_info_list)
     
    content_info,got_content=get_content(uri,is_root)
    content_info_list << content_info
     
    append_relative_contents(got_content,content_info_list) if /html/.match(content_info.type)
    content_info_list
  end

  def self.append_relative_contents(page,content_info_list)
    base_uri=page.uri
    raw_image_uris=page.search('//img').map{|i| i['src']}
    raw_image_uris.push(*(page.search('//body').find_all{|i| i['background']}.map{|i| i['background']}))
    raw_image_uris.push(*(page.search('//th').find_all{|i| i['background']}.map{|i| i['background']}))
    raw_image_uris.push(*(page.search('//td').find_all{|i| i['background']}.map{|i| i['background']}))
    image_uris=raw_image_uris.map{|i| resolve_relative_uri(base_uri,i)}.grep(/^(http|ftp)/)
   
    raw_frame_uris=page.frames.map{|f| f.uri}
    frame_uris=raw_frame_uris.map{|i| resolve_relative_uri(base_uri,i)}.grep(/^(http|ftp)/)
   
    raw_iframe_uris=page.iframes.map{|f| f.uri}
    iframe_uris=raw_iframe_uris.map{|i| resolve_relative_uri(base_uri,i)}.grep(/^(http|ftp)/)

    raw_css_uris=page.search('link[@rel="stylesheet"]').map{|l| l['href']}
    css_uris=raw_css_uris.map{|i| resolve_relative_uri(base_uri,i)}.grep(/^(http|ftp)/)

    raw_script_uris=page.search('script').find_all{|s| s['src']}.map{|s| s['src']}
    script_uris=raw_script_uris.map{|i| resolve_relative_uri(base_uri,i)}.grep(/^(http|ftp)/)


    raw_urls = ( image_uris + frame_uris + iframe_uris + css_uris + script_uris )
    target_content_urls = raw_urls.map{|u| u.gsub(/#.*/,'')}.uniq.find_all{|u| content_info_list.any?{|content| u != content.uri}}
   
    target_content_urls.each{|uri| get_contents(uri,false,content_info_list)}
  end

  def self.resolve_relative_uri(base_uri,target_uri)
    URI.join(base_uri.to_s,target_uri).to_s
  end

  def self.create_mail_part(content)
    part=TMail::Mail.new

    part['content-location']=content.uri
    part.content_type = content.type
    if /html/.match(content.type)
      part.transfer_encoding = '8bit'
      part.body = content.body
    else
      part.transfer_encoding = 'base64'
      b64encoded_body = [content.body].pack('m').chomp.gsub(/.{76}/, "\\1\n")
      part.body = b64encoded_body
    end
    part
  end

  def self.create_mail(title,parts)
    mail=TMail::Mail.new
    mail.from='url2MHTML'
    mail.subject = title
    mail.date = Time.now
    mail.mime_version = '1.0'
    mail['X-MimeOLE']='url2MHTML'

    mail.body = "This is a multi-part message in MIME format.\n"

    parts.each{|part| mail.parts.push(part) }
   
    mail.content_type='multipart/related; type="text/html"'
    mail
  end
  
  def self.capture(uri)
    page_content_list=get_contents(uri,true,[])
    title=page_content_list.find(ContentInfo.new(nil,nil,nil,nil,'no title')) { |content| content.is_root == true }.title
    mail_parts=page_content_list.map{|content| create_mail_part(content)}
    mail=create_mail(title,mail_parts)
    mail.encoded
  end
end 
