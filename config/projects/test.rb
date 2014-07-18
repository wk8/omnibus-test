
name 'test'
maintainer 'wk'
homepage 'getchef.com'

install_path    '/opt/test'
build_version   Omnibus::BuildVersion.semver
build_iteration 1

# creates required build directories
dependency 'preparation'

# test dependencies/components
# dependency 'git'

# version manifest file
dependency 'version-manifest'

exclude '\.git*'
exclude 'bundler\/git'
