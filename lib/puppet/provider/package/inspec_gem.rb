require 'puppet/provider/package'
require 'uri'

# Ruby gems support.
Puppet::Type.type(:package).provide :inspec_gem, parent: :gem do
  desc "Inspec Embedded Ruby Gem support. If a URL is passed via `source`, then
    that URL is used as the remote gem repository; if a source is present but is
    not a valid URL, it will be interpreted as the path to a local gem file.  If
    source is not present at all, the gem will be installed from the default gem
    repositories."

  has_feature :versionable, :install_options

  commands gemcmd:
    if File.exist?("#{ENV['SYSTEMDRIVE']}\\opt\\inspec\\embedded\\bin\\gem.bat")
      "#{ENV['SYSTEMDRIVE']}\\opt\\inspec\\embedded\\bin\\gem.bat"
    else
      '/opt/inspec/embedded/bin/gem'
    end

  def uninstall
    command = [command(:gemcmd), 'uninstall']
    command << '-x' << '-a' << resource[:name]
    output = execute(command)

    # Apparently some stupid gem versions don't exit non-0 on failure
    raise "Could not uninstall: #{output.chomp}" if output.include?('ERROR')
  end
end
