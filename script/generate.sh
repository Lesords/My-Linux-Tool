#!/bin/bash

build_all="no"
build_platform="x86_64"

source "./script/config.sh"

bat()
{
    bat_version="v0.25.0"
    bat="bat-${bat_version}-${build_platform}-unknown-linux-gnu"
    bat_url="https://github.com/sharkdp/bat/releases/download/${bat_version}/${bat}.tar.gz"

    curl -LJO $bat_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf ${bat}.tar.gz && mv ${bat}/bat ${bin_path}
}

ctags()
{
    ctags="uctags-2024.02.04-linux-${build_platform}"
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
    lazygit_version="0.52.0"
    lazygit="lazygit_${lazygit_version}_Linux_x86_64"
    if [ "$build_platform" == "aarch64" ]; then
        lazygit="lazygit_${lazygit_version}_Linux_arm64"
    fi
    lazygit_url="https://github.com/jesseduffield/lazygit/releases/download/v${lazygit_version}/${lazygit}.tar.gz"

    curl -LJO $lazygit_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf ${lazygit}.tar.gz && mv "lazygit" ${bin_path}
}

rg()
{
    rg_version="14.1.1"
    rg="ripgrep-${rg_version}-x86_64-unknown-linux-musl"
    if [ "$build_platform" == "aarch64" ]; then
        rg="ripgrep-${rg_version}-aarch64-unknown-linux-gnu"
    fi
    rg_url="https://github.com/BurntSushi/ripgrep/releases/download/${rg_version}/${rg}.tar.gz"

    curl -LJO $rg_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf ${rg}.tar.gz && mv ${rg}/rg ${bin_path}
}

tokei()
{
    tokei_version="v13.0.0-alpha.0"
    tokei="tokei-${build_platform}-unknown-linux-gnu.tar.gz"
    tokei_url="https://github.com/XAMPPRocky/tokei/releases/download/${tokei_version}/${tokei}"

    curl -LJO $tokei_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf $tokei && mv "tokei" ${bin_path}
}

joshuto()
{
    joshuto_version="v0.9.9"
    joshuto="joshuto-${joshuto_version}-${build_platform}-unknown-linux-musl"
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
    delta_version="0.18.2"
    delta="git-delta-musl_${delta_version}_amd64.deb"
    if [ "$build_platform" == "aarch64" ]; then
        delta="git-delta_${delta_version}_arm64.deb"
    fi
    delta_url="https://github.com/dandavison/delta/releases/download/${delta_version}/${delta}"

    curl -LJO $delta_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    dpkg -x ${delta} . && mv "usr/bin/delta" ${bin_path}
}

fzf()
{
    fzf_version="0.63.0"
    fzf="fzf-${fzf_version}-linux_amd64.tar.gz"
    if [ "$build_platform" == "aarch64" ]; then
        fzf="fzf-${fzf_version}-linux_arm64.tar.gz"
    fi
    fzf_url="https://github.com/junegunn/fzf/releases/download/v${fzf_version}/${fzf}"

    curl -LJO $fzf_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf $fzf && mv "fzf" ${bin_path}
}

clangd()
{
    clangd="clangd-10_10.0.0-4ubuntu1~18.04.2_amd64.deb"
    clangd_url="https://launchpadlibrarian.net/488890559/${clangd}"
    libclangd="libclang-cpp10_10.0.0-4ubuntu1_amd64.deb"
    libclangd_url="http://launchpadlibrarian.net/475399973/${libclangd}"
    libllvm="libllvm10_10.0.0-4ubuntu1_amd64.deb"
    libllvm_url="http://launchpadlibrarian.net/475399976/${libllvm}"

    curl -LJO $clangd_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1
    dpkg -x ${clangd} . && mv "`realpath usr/bin/clangd*`" ${bin_path}

    curl -LJO $libclangd_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1
    dpkg -x ${libclangd} . && mv "usr/lib/llvm-10/lib/libclang-cpp.so.10" ${lib_path}

    curl -LJO $libllvm_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1
    dpkg -x ${libllvm} . && mv "usr/lib/x86_64-linux-gnu/libLLVM-10.so.1" ${lib_path}
}

bear()
{
    bear="bear_2.4.3-1_all.deb"
    bear_url="https://launchpadlibrarian.net/462421353/${bear}"
    libear="libear_2.4.3-1_amd64.deb"
    libear_url="http://launchpadlibrarian.net/462421356/${libear}"

    curl -LJO $bear_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1
    dpkg -x ${bear} . && mv "usr/bin/bear" ${bin_path}

    curl -LJO $libear_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1
    dpkg -x ${libear} . && mv "usr/lib/x86_64-linux-gnu/bear/libear.so" ${lib_path}
}

ttyper()
{
    ttyper_version="v1.6.0"
    ttyper="ttyper-${build_platform}-unknown-linux-musl"
    ttyper_url="https://github.com/max-niederman/ttyper/releases/download/${ttyper_version}/${ttyper}.tar.gz"

    curl -LJO $ttyper_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf ${ttyper}.tar.gz && mv ttyper ${bin_path}
}

fd()
{
    fd_version="v10.2.0"
    fd="fd-${fd_version}-${build_platform}-unknown-linux-musl"
    fd_url="https://github.com/sharkdp/fd/releases/download/${fd_version}/${fd}.tar.gz"

    curl -LJO $fd_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf $fd.tar.gz && mv ${fd}/fd ${bin_path}
}

hexyl()
{
    hexyl_version="v0.16.0"
    hexyl="hexyl-${hexyl_version}-x86_64-unknown-linux-musl"
    if [ "$build_platform" == "aarch64" ]; then
        hexyl="hexyl-${hexyl_version}-arm-unknown-linux-musleabihf"
    fi
    hexyl_url="https://github.com/sharkdp/hexyl/releases/download/${hexyl_version}/${hexyl}.tar.gz"

    curl -LJO $hexyl_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf $hexyl.tar.gz && mv ${hexyl}/hexyl ${bin_path}
}

btop()
{
    btop_version="v1.4.3"
    btop="btop-${build_platform}-linux-musl.tbz"
    btop_url="https://github.com/aristocratos/btop/releases/download/${btop_version}/${btop}"

    curl -LJO $btop_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar xvf $btop && mv btop/bin/btop ${bin_path}
}

fastfetch()
{
    fastfetch_version="2.46.0"
    if [ -z "$(strings /lib/x86_64-linux-gnu/libc.so.6 | grep GLIBC_2.34)" ]; then
        fastfetch_version="2.40.0"
    fi

    fastfetch="fastfetch-linux-amd64" # "fastfetch-musl-amd64" not work
    if [ "$build_platform" == "aarch64" ]; then
        fastfetch="fastfetch-linux-aarch64"
    fi
    fastfetch_url="https://github.com/fastfetch-cli/fastfetch/releases/download/${fastfetch_version}/${fastfetch}.tar.gz"

    curl -LJO $fastfetch_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf ${fastfetch}.tar.gz && mv ${fastfetch}/usr/bin/fastfetch ${bin_path}
}

hyperfine()
{
    hyperfine_version="v1.19.0"
    hyperfine="hyperfine-${hyperfine_version}-x86_64-unknown-linux-musl"
    if [ "$build_platform" == "aarch64" ]; then
        hyperfine="hyperfine-${hyperfine_version}-arm-unknown-linux-musleabihf"
    fi
    hyperfine_url="https://github.com/sharkdp/hyperfine/releases/download/${hyperfine_version}/${hyperfine}.tar.gz"

    curl -LJO $hyperfine_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf ${hyperfine}.tar.gz && mv ${hyperfine}/hyperfine ${bin_path}
}

filebrowser()
{
    filebrowser_version="v2.33.10"
    filebrowser="linux-amd64-filebrowser"
    if [ "$build_platform" == "aarch64" ]; then
        filebrowser="linux-arm64-filebrowser"
    fi
    filebrowser_url="https://github.com/filebrowser/filebrowser/releases/download/${filebrowser_version}/${filebrowser}.tar.gz"

    curl -LJO $filebrowser_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf ${filebrowser}.tar.gz && mv "filebrowser" ${bin_path}
}

mihomo()
{
    mihomo_version="v1.19.12"
    mihomo="mihomo-linux-386-${mihomo_version}.deb"
    if [ "$build_platform" == "aarch64" ]; then
        mihomo="mihomo-linux-arm64-${mihomo_version}.deb"
    fi
    mihomo_url="https://github.com/MetaCubeX/mihomo/releases/download/${mihomo_version}/${mihomo}"
    mmdb_version="20250812"
    mmdb_url="https://github.com/Dreamacro/maxmind-geoip/releases/download/${mmdb_version}/Country.mmdb"

    curl -LJO $mihomo_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1
    curl -LJO $mmdb_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    dpkg -x ${mihomo} . && mv "usr/bin/mihomo" ${bin_path} && mv "Country.mmdb" ${config_path}
}

yazi()
{
    yazi_version="v25.5.31"
    yazi="yazi-x86_64-unknown-linux-musl"
    if [ "$build_platform" == "aarch64" ]; then
        yazi="yazi-aarch64-unknown-linux-musl"
    fi
    yazi_url="https://github.com/sxyazi/yazi/releases/download/${yazi_version}/${yazi}.zip"

    curl -LJO $yazi_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip ${yazi}.zip && mv ${yazi}/ya* ${bin_path}
}

node()
{
    node_version="v22.18.0"
    node="node-${node_version}-linux-x64"
    if [ "$build_platform" == "aarch64" ]; then
        node="node-${node_version}-linux-arm64"
    fi
    node_url="https://nodejs.org/dist/${node_version}/${node}.tar.xz"

    curl -LJO $node_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar -Jxvf ${node}.tar.xz && mv ${node}/bin/* ${bin_path} && mv ${node}/lib/node_modules ${lib_path}
}

exa()
{
    exa_version="v0.10.1"
    exa="exa-linux-x86_64-musl-${exa_version}"
    if [ "$build_platform" == "aarch64" ]; then
        exa="exa-linux-armv7-${exa_version}"
    fi
    exa_url="https://github.com/ogham/exa/releases/download/${exa_version}/${exa}.zip"

    curl -LJO $exa_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    unzip ${exa}.zip && mv bin/exa ${bin_path}
}

choose()
{
    choose_version="v1.3.7"
    choose="choose-x86_64-unknown-linux-musl"
    if [ "$build_platform" == "aarch64" ]; then
        choose="choose-aarch64-unknown-linux-gnu"
    fi
    choose_url="https://github.com/theryangeary/choose/releases/download/${choose_version}/${choose}"

    curl -LJO $choose_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    chmod u+x ${choose} && mv ${choose} ${bin_path}/choose
}

zoxide()
{
    zoxide_version="0.9.8"
    zoxide="zoxide-${zoxide_version}-x86_64-unknown-linux-musl"
    if [ "$build_platform" == "aarch64" ]; then
        zoxide="zoxide-${zoxide_version}-aarch64-unknown-linux-musl"
    fi
    zoxide_url="https://github.com/ajeetdsouza/zoxide/releases/download/v${zoxide_version}/${zoxide}.tar.gz"

    curl -LJO $zoxide_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf ${zoxide}.tar.gz && mv zoxide ${bin_path}
}

gtags()
{
    cwd=$PWD
    gtags_version="6.6.14"
    gtags="global-${gtags_version}.tar.gz"
    gtags_url="https://ftp.gnu.org/gnu/global/${gtags}"

    curl -LJO $gtags_url && tar zxvf $gtags

    cd "global-${gtags_version}" && mkdir build

    if [ "`dpkg -l | grep -E ncurses.*-dev`" ]; then
        ./configure --prefix=$PWD/build && make -j5 && make install && mv build/bin/* ${bin_path}
    else
        ./configure --disable-gtagscscope --prefix=$PWD/build && make -j5 && make install && mv build/bin/* ${bin_path}
    fi

    cd $cwd
}

tig()
{
    tig="tig-2.5.12"
    tig_url="https://github.com/jonas/tig/releases/download/${tig}/${tig}.tar.gz"

    if [ -z "`dpkg -l | grep -E ncurses.*-dev`" ]; then
        echo "Missing libncurses-dev library"
        return 0
    fi

    curl -LJO $tig_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar zxvf ${tig}.tar.gz && make -C ${tig} -j $cores && mv ${tig}/src/tig ${bin_path}
}

vifm()
{
    vifm_version="0.14.3"
    vifm="vifm-${vifm_version}"
    vifm_url="https://github.com/vifm/vifm/releases/download/v${vifm_version}/${vifm}.tar.bz2"

    if [ -z "`dpkg -l | grep -E ncurses.*-dev`" ]; then
        echo "Missing libncurses-dev library"
        return 0
    fi

    curl -LJO $vifm_url
    [ $? -ne 0 ] && echo "curl failed here" && return 1

    tar xvf ${vifm}.tar.bz2 && cd ${vifm}
    ./configure && make -j $cores && mv ./src/vifm ${bin_path} && cd ..
}

main()
{
    [ ! -d ${bin_path} ] && mkdir ${bin_path}
    [ ! -d ${lib_path} ] && mkdir ${lib_path}
    [ ! -d ${config_path} ] && mkdir ${config_path}
    [ -d tmp ] && rm -rf ./tmp
    mkdir tmp && cd tmp

    for i in ${bin_list[@]}; do
        if [ -f "$bin_path/$i" ]; then
            echo "=== ${i} already done here ===" && echo
            continue
        fi

        echo "=== start to download ${i} ==="
        $i
        if [ $? -eq 0 ]; then
            echo "=== ${i} download successful ===" && echo
        else
            echo "=== ${i} download failed ===" && return 1
        fi
    done

    if [[ "$build_all" == "yes" ]]; then
        echo "=== start to generate extra tools ===" && echo
        for i in ${bin_build_list[@]}; do
            if [ -f "$bin_path/$i" ]; then
                echo "=== ${i} already done here ===" && echo
                continue
            fi

            echo "=== start to download & build ${i} ==="
            $i
            if [ $? -eq 0 ]; then
                echo "=== ${i} download & build successful ===" && echo
            else
                echo "=== ${i} download & build failed ===" && return 1
            fi
        done
    fi

    cd .. && rm -rf tmp
}

while [ $# -ge 1 ]; do
    case $1 in
        -a|--all)
            build_all="yes"
            ;;
        --arm|--arm64)
            build_platform="aarch64"
            ;;
    esac
    shift
done

main
