nave_sh = "$(curl https://raw.githubusercontent.com/isaacs/nave/master/nave.sh)"
version = node['quoteapp']['node_version']

execute "bash -c \"#{nave_sh} usemain #{version}\""
