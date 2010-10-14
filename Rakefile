require 'rake/clean'

# Deploying stuff starts here
require 'net/ssh'
require 'net/scp'

# Change the following constants accordingly
USER = 'yourusername'
HOSTNAME = 'yourhostname.com'
APPLICATION = 'hello_sprouts'
PORT = '8090'
# end constants

REMOTE_DIR = "/home/#{USER}/www/#{APPLICATION}"

desc "Deploy the site"
task :deploy => :clean do
  FileUtils.rmtree 'tmp'
  
  puts "building sproutcore..."
  status = system 'sc-build'
  
  if status
    deployid = `ls tmp/build/http\:/#{HOSTNAME}\:#{PORT}/#{APPLICATION}/en`.strip
    
    puts "creating archive..."
    system "cd tmp/build/http\:/#{HOSTNAME}\:#{PORT}/ && tar -cvpzf static.tar.gz #{APPLICATION}/ sproutcore/"    
      
		puts "uploading archive..."
		Net::SCP.start(HOSTNAME, USER) do |scp|
		  scp.upload! "tmp/build/http:/#{HOSTNAME}:#{PORT}/static.tar.gz",  REMOTE_DIR
		end
  
    puts "setting up server..."
		Net::SSH.start(HOSTNAME, USER) do |ssh|
		  ssh.exec! "rm -rf ~/www/#{APPLICATION}/#{APPLICATION}"
		  ssh.exec! "rm -rf ~/www/#{APPLICATION}/sproutcore"
		  ssh.exec! "rm ~/www/#{APPLICATION}/index.html"
		  ssh.exec! "cd ~/www/#{APPLICATION}/ && tar xzvf static.tar.gz"
		  ssh.exec! "rm ~/www/#{APPLICATION}/static.tar.gz"
		  ssh.exec! "ln -s ~/www/#{APPLICATION}/#{APPLICATION}/en/#{deployid}/index.html ~/www/#{APPLICATION}/index.html"
		end
		puts "SUCCESS!"
  end
  
end

