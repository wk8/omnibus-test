#
# Copyright:: Copyright (c) 2012-2014 Chef Software, Inc.
#

# We have our custom definition here to add the 'uuid-ossp' module
# to the build (see http://www.postgresql.org/docs/8.3/static/uuid-ossp.html)
# TODO: ideally, this could be made an option on the omnibus-software repo's
# definition

name "postgresql"
default_version "9.2.8"

dependency "zlib"
dependency "openssl"
dependency "libedit"
dependency "ncurses"
dependency "libossp-uuid"

version "9.1.9" do
  source :md5 => "6b5ea53dde48fcd79acfc8c196b83535"
end

version "9.2.8" do
  source :md5 => "c5c65a9b45ee53ead0b659be21ca1b97"
end

version "9.3.4" do
  source :md5 => "d0a41f54c377b2d2fab4a003b0dac762"
end

source :url => "http://ftp.postgresql.org/pub/source/v#{version}/postgresql-#{version}.tar.bz2"
relative_path "postgresql-#{version}"

configure_env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--with-ossp-uuid",
           "--with-libedit-preferred",
           "--with-openssl --with-includes=#{install_dir}/embedded/include",
           "--with-libraries=#{install_dir}/embedded/lib"].join(" "), :env => configure_env
  command "make -j #{max_build_jobs}", :env => {"LD_RUN_PATH" => "#{install_dir}/embedded/lib"}
  command "make install"

  # and ossp-uuid
  command "make -C contrib/uuid-ossp all install"
end
