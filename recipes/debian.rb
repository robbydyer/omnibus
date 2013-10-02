#
# Cookbook Name:: omnibus
# Recipe:: debian
#
# Copyright 2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apt"
include_recipe "build-essential"
include_recipe "git"

%w{
  dpkg-dev
  libxml2
  libxml2-dev
  libxslt1.1
  libxslt1-dev
  cmake
}.each do |pkg|

  package pkg

end

# TODO: figure out what the root cause is and remove this dep
#
# Background: Erlang fails to ./configure erts on Ubuntu 12.04 platforms
# because the test program it uses to detect ncurses fails to find ncurses in
# the embedded/ directory. Installing ncurses-devel causes ./configure to
# work, and the resulting erlang is linked to the correct ncurses shared
# object (in embedded/). So this is ugly, but required to make erlang build.
if platform?("ubuntu") and node['platform_version'].to_f >= 12.04
  package "ncurses-dev"
end
