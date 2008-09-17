Gem::Specification.new do |s|
  s.name = %q{url2mhtml}
  s.version = "0.0.2"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["forgithubid"]
  s.date = %q{2008-09-17}
  s.default_executable = %q{url2mhtml}
  s.description = %q{generate to MHTML from URL.}
  s.email = %q{forgithubid@gmail.com}
  s.executables = ["url2mhtml"]
  s.extra_rdoc_files = ["README", "ChangeLog"]
  s.files = ["README", "ChangeLog", "Rakefile", "bin/url2mhtml", "doc/classes", "doc/classes/Url2mhtml.html", "doc/classes/Url2mhtml.src", "doc/classes/Url2mhtml.src/M000001.html", "doc/classes/Url2mhtml.src/M000002.html", "doc/classes/Url2mhtml.src/M000003.html", "doc/classes/Url2mhtml.src/M000004.html", "doc/classes/Url2mhtml.src/M000005.html", "doc/classes/Url2mhtml.src/M000006.html", "doc/classes/Url2mhtml.src/M000007.html", "doc/classes/Url2mhtml.src/M000008.html", "doc/classes/Url2mhtmlTest.html", "doc/classes/Url2mhtmlTest.src", "doc/classes/Url2mhtmlTest.src/M000009.html", "doc/classes/Url2mhtmlTest.src/M000010.html", "doc/classes/Url2mhtmlTest.src/M000011.html", "doc/created.rid", "doc/files", "doc/files/lib", "doc/files/lib/url2mhtml_rb.html", "doc/files/test", "doc/files/test/test_helper_rb.html", "doc/files/test/url2mhtml_test_rb.html", "doc/fr_class_index.html", "doc/fr_file_index.html", "doc/fr_method_index.html", "doc/index.html", "doc/rdoc-style.css", "test/test_helper.rb", "test/url2mhtml_test.rb", "lib/url2mhtml.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/fromgit/url2mhtml/tree/master}
  s.rdoc_options = ["--title", "url2mhtml documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.1.1}
  s.summary = %q{generate to MHTML from URL.}
  s.test_files = ["test/url2mhtml_test.rb"]

  s.add_dependency(%q<mechanize>, [">= 0.7.8"])
  s.add_dependency(%q<tmail>, [">= 1.2.3.1"])
end
