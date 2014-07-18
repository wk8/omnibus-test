
name 'test'
maintainer 'CHANGE ME'
homepage 'CHANGEME.com'

install_path    '/opt/test'
build_version   Omnibus::BuildVersion.semver
build_iteration 1

# creates required build directories
dependency 'preparation'

# test dependencies/components
# dependency 'somedep'

# version manifest file
dependency 'version-manifest'

exclude '\.git*'
exclude 'bundler\/git'
