spec_rig_path = File.expand_path(File.dirname(__FILE__) + "/../examples_lib/spec_rig" )
$LOAD_PATH << spec_rig_path
Dir[spec_rig_path + "/*.rb"].each { |file| require file }

require 'time'
require 'fileutils'
