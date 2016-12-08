# puppet-inspec

[![Build Status](https://travis-ci.org/jaxxstorm/puppet-inspec.svg?branch=master)](https://travis-ci.org/jaxxstorm/puppet-inspec)

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
2. [Setup - The basics of getting started with puppet-inspec](#setup)
    * [What puppet-inspec affects](#what-puppet-inspec-affects)
    * [Beginning with puppet-inspec](#beginning-with-puppet-inspec)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)


## Module description

This module will download and install [inspec](http://inspec.io/) by [Chef](https://www.chef.io/), a compliance as code tool.

## Setup

### What puppet-inspec affects

puppet-inspec will simply download the package from the package url (or optionally from your own repo) and install it. That's it!

### Beginning with puppet-inspec

Simply include the inspec module like so:

```puppet
  include ::inspec
```

You may want to use a class include if you wish to override parameters:

```puppet
  class { '::inspec' :
		install_method => 'package'
  }
```

## Usage

### I just want to install inspec, what's the minimum I need

```puppet
  include ::inspec
```

### I want to install the package from a custom url

Specify the URL to download from. It's a good idea to make sure you also specify the version specifically, so Puppet knows about it

```puppet
  class { '::inspec' :
    download_url => 'http://my_url/inspec-1.7.1-1.el6.x86_64.rpm'
    version      => '1.7.1-1'
  }
```

## Reference

### Classes

#### Public Classes
  * [`inspec`](#inspec): Installs inspec in your environment.
  * [`inspec::profile`](#inspecprofile): Downloads and installs inspec profile zip packages

#### Private Classes
  * [`inspec::install`]: Installs the required inspec package using the method you specify
  

### `inspec`

#### Parameters

##### `package_name` [String]

Specifies the package to install for inspec

##### `package_version` [String]

Specifies the version of the inspec package to install (default: 1.7.1-1)

##### `install_method` [String]

Specifies the install method you wish to use. Possible values are: 'url' (default) : 'package' : 'gem'
If package is specified, it's assumed the package is in an available repo

##### `download_path` [String]

Specifies the temporary path to download the inspec package to before installing it (default: `/tmp/`)

##### `download_url_base` [String]

Specifices the url base for the chef website to grab the package from (default: `https://packages.chef.io/stable/`)

##### `download_url` [String]

Specifies a custom download_url to grab the package from (default: undef)

##### `os_arch` [String]

Specifies the Operating System Architecture of the package you wish to download (default: platform dependant)

##### `os_family` [String]

Specifies the operating system family of the package you wish to download (default: platform dependant)

##### `os_ver` [String]

Specifies the major relase of the package you wish to download

##### `package_suffix` [String]

Specifies the suffix of the package you wish to download (default: platform dependant)

##### `config_dir` [String]

Specifies the config directory for inspec profiles (default: `/etc/inspec`)

##### `profiles_dir` [String]

Specifies the directory within the config dir to place profiles (default: `profiles.d`)

##### `downloads_dir` [String]

Specifies the directory to download profiles to if using the defined type (default: `${config_dir}/downloads`)

##### `purge` [Bool]

Specifies whether Puppet should purge the config directories of files not managed by Puppet (default: false)

### `inspec::profile`

#### Parameters

##### `source` [String]

Specifies the full URL to download inspec profiles from

##### `ensure` [String]

Specifies whether the profile should be present or not (default: `present`)

##### `extract` [Bool]

Specifies whether the profile should be extract. Leave this along unless you know what you're doing (default: `true)

##### `extract_path` [String]

Specifies a custom directory to extract profiles to (default: undef)

## Limitations

The module only currently works on RedHat Enterprise Linux variants
