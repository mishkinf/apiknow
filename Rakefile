require 'rspec/core/rake_task'
require 'resources'
require 'templates/confluence_document'
require 'templates/text_document'
require 'templates/html_document'
require 'templates/media_wiki_document'

spec_tasks = Dir['spec/*/'].map { |d| File.basename(d) }

spec_tasks.each do |folder|
  RSpec::Core::RakeTask.new("spec:#{folder}") do |t|
    t.pattern = "./spec/#{folder}/**/*_spec.rb"
    t.rspec_opts = %w(-fs --color)
  end
end

desc "Run complete application spec suite"
task 'spec' => spec_tasks.map { |f| "spec:#{f}" }

task :default do
  puts `cat README`
end

desc "Generate API Documentation"
task 'generate_docs' do
  resources = Resources.load

  confluence_doc = ConfluenceDocument.new resources
  confluence_doc.save('tmp/documentation.confluence')

  html_doc = HtmlDocument.new resources
  html_doc.save('tmp/documentation.html')

  text_doc = TextDocument.new resources
  text_doc.save('tmp/documentation.txt')

  mediawiki_doc = MediaWikiDocument.new resources
  mediawiki_doc.save('tmp/documentation.wiki')
end