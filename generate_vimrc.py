if __name__ == '__main__':
    vimrc_plugin = '.vimrc_plugin_template'
    vimrc_customize = '.vimrc_customize_template'
    with open(vimrc_plugin, 'r') as fp:
        plugins = fp.read()
    runtime_path = '/etc/vim/bundle/Vundle.vim'
    global_plugins = plugins.format(runtime_path)
    runtime_path = '~/.vim/bundle/Vundle.vim'
    local_plugins = plugins.format(runtime_path)

    with open(vimrc_customize, 'r') as fp:
        customize = fp.read()

    output = '.vimrc_plugin_global'
    with open(output, 'w') as fp:
        fp.write(global_plugins)

    output = '.vimrc_plugin'
    with open(output, 'w') as fp:
        fp.write(local_plugins)
    
    output = '.vimrc_global'
    with open(output, 'w') as fp:
        fp.write(global_plugins + '\n' + customize)

    output = '.vimrc'
    with open(output, 'w') as fp:
        fp.write(local_plugins + '\n' + customize)
