#!/bin/bash

source "./script/config.sh"

bat()
{
    bat_version="v0.24.0"
    bat="bat-${bat_version}-x86_64-unknown-linux-gnu"
    bat_url="https://github.com/sharkdp/bat/releases/download/${bat_version}/${bat}.tar.gz"

    curl -LJO $bat_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf ${bat}.tar.gz && mv ${bat}/bat ${bin_path}
}

ctags()
{
    ctags="uctags-2024.02.04-linux-x86_64"
    ctags_url="https://github.com/universal-ctags/ctags-nightly-build/releases/download/2024.02.04%2B6c5cba02f4bbb8549f74250490c9cda27b7b48c6/${ctags}.tar.xz"

    curl -LJO $ctags_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar Jxvf ${ctags}.tar.xz && mv ${ctags}/bin/* ${bin_path}
}

diff-so-fancy()
{
    diff_so_fancy="https://github.com/so-fancy/diff-so-fancy/releases/download/v1.4.4/diff-so-fancy"

    curl -LJO $diff_so_fancy
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    chmod u+x "diff-so-fancy" && mv "diff-so-fancy" ${bin_path}
}

lazygit()
{
    lazygit_version="0.40.2"
    lazygit="lazygit_${lazygit_version}_Linux_x86_64"
    lazygit_url="https://github.com/jesseduffield/lazygit/releases/download/v${lazygit_version}/${lazygit}.tar.gz"

    curl -LJO $lazygit_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf ${lazygit}.tar.gz && mv "lazygit" ${bin_path}
}

rg()
{
    rg_version="14.1.0"
    rg="ripgrep-${rg_version}-x86_64-unknown-linux-musl"
    rg_url="https://github.com/BurntSushi/ripgrep/releases/download/${rg_version}/${rg}.tar.gz"

    curl -LJO $rg_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf ${rg}.tar.gz && mv ${rg}/rg ${bin_path}
}

tokei()
{
    tokei="tokei-x86_64-unknown-linux-gnu.tar.gz"
    tokei_url="https://github.com/XAMPPRocky/tokei/releases/download/v13.0.0-alpha.0/${tokei}"

    curl -LJO $tokei_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf $tokei && mv "tokei" ${bin_path}
}

joshuto()
{
    joshuto_version="v0.9.6"
    joshuto="joshuto-${joshuto_version}-x86_64-unknown-linux-musl"
    joshuto_url="https://github.com/kamiyaa/joshuto/releases/download/${joshuto_version}/${joshuto}.tar.gz"

    curl -LJO $joshuto_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf $joshuto.tar.gz && mv ${joshuto}/joshuto ${bin_path}
}

icdiff()
{
    git_icdiff="https://raw.githubusercontent.com/jeffkaufman/icdiff/master/git-icdiff"
    icdiff="https://raw.githubusercontent.com/jeffkaufman/icdiff/master/icdiff"

    curl -LJO $git_icdiff
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    curl -LJO $icdiff
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    chmod u+x "git-icdiff" && mv "git-icdiff" ${bin_path}
    chmod u+x "icdiff" && mv "icdiff" ${bin_path}
}

delta()
{
    delta_version="0.16.5"
    delta="git-delta-musl_${delta_version}_amd64.deb"
    delta_url="https://github.com/dandavison/delta/releases/download/${delta_version}/${delta}"

    curl -LJO $delta_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    dpkg -x ${delta} . && mv "usr/bin/delta" ${bin_path}
}

main()
{
    [ ! -d ${bin_path} ] && mkdir ${bin_path}
    [ -d tmp ] && rm -rf ./tmp
    mkdir tmp && cd tmp

    for i in ${bin_list[@]}; do
        echo "=== start to download ${i} ==="
        $i
        if [ $? -eq 0 ]; then
            echo "=== ${i} download successful ===" && echo
        else
            echo "=== ${i} download failed ===" && return 1
        fi
    done

    cd .. && rm -rf tmp
}

main
