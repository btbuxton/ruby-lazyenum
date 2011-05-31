MY_DIR = File.expand_path(File.dirname(__FILE__))

def lib_require(name)
  begin
    require name
  rescue LoadError
    $LOAD_PATH << File.expand_path(File.join(MY_DIR, '..', 'lib'))
    require name
  end
end

def tests_require(name)
  begin
    require name
  rescue LoadError
    $LOAD_PATH << MY_DIR
    require name
  end
end

lib_require 'lazy_enumerable'
tests_require 'lazy_enumerable_test'