<p><a target="_blank" rel="noopener noreferrer" href="https://camo.githubusercontent.com/98f307e50e222b95c1695c11208bd91565f8b7c7/687474703a2f2f706f6f6c2e626974636f696e6e2e62697a2f626974636f696e2d6e6f76612e706e67"><img src="https://camo.githubusercontent.com/98f307e50e222b95c1695c11208bd91565f8b7c7/687474703a2f2f706f6f6c2e626974636f696e6e2e62697a2f626974636f696e2d6e6f76612e706e67" data-canonical-src="http://pool.bitcoinn.biz/bitcoin-nova.png" style="max-width:100%;"></a></p>
--
<h3>How To Upgrade from an older version</h3>
<h4>(windows, mac, linux)</h4>
<ul>
<li>run the old <code>Bitcoinn</code> to sync your chain fully</li>
<li>with the old <code>simplewallet</code> fully synced, open <code>simplewallet</code></li>
<li>open your wallet</li>
<li>export your SPEND and VIEW keys, this is important. <code>export_keys</code> If you are in windows, right click the titlebar of the CMD window and select EDIT then MARK so be able to copy and paste your keys.</li>
<li>Unzip the new files into a NEW FOLDER outside of the old version folder</li>
<li>Close the old version folder <code>Bitcoinnova-forkd</code> and <code>simplewallet</code> by typing <code>exit</code> into each window</li>
<li>Run the new <code>Bitcoinnovd</code></li>
<li>Run the new <code>simplewallet</code></li>
<li>Press <strong>I</strong> for IMPORT in simplewallet</li>
<li>Use any filename for the wallet name, it does not have to be the same</li>
<li>Use any password for wallet password, it does not have to be the same as the last</li>
<li>Enter your <code>spend_key</code> and your <code>view_key</code> from step 4</li>
</ul>
<h3>RPC API Changes</h3>
<p><strong>Developers seeking to integrate the simplewallet or walletd daemons into their applications should note this crucial change.</strong></p>
<p>Mandatory authentication has been added to the JSON RPC API interfaces of simplewallet and walletd. To maintain back compatibility with old services, the <code>--rpc-legacy-security</code> flag has been introduced to allow password-less access to the RPC.</p>
<p>However, all new applications going forward should make use of the <code>--rpc-password</code> flag to enable authentication of JSON RPC queries.</p>
<p>To pass the password to the RPC interface, add an additional field <code>password</code> to the JSON object:</p>
<pre><code>{
"jsonrpc": "2.0",
"method": "transfer",
"params": {},
"password": "&lt;the password&gt;"
}
</code></pre>
<h3>How To Compile</h3>
<h4>Ubuntu 16.xx LTS</h4>
<ul>
<li><code>sudo apt-get update</code></li>
<li><code>sudo apt-get -y install build-essential python-dev gcc-4.9 g++-4.9 git cmake libboost1.58-all-dev librocksdb-dev</code></li>
<li><code>export CXXFLAGS="-std=gnu++11"</code></li>
<li><code>git clone https://github.com/Bitcoin-N/Bitcoinnova-fork.git</code></li>
<li><code>cd Bitcoinnova-fork</code></li>
<li><code>mkdir build &amp;&amp; cd $_</code></li>
<li><code>cmake ..</code></li>
<li><code>make</code></li>
</ul>
<h4>Windows 10</h4>
<h5>Prerequisites</h5>
<ul>
<li>Install <a href="https://www.visualstudio.com/thank-you-downloading-visual-studio/?sku=Community&amp;rel=15&amp;page=inlineinstall" rel="nofollow">Visual Studios 2017 Community Edition</a></li>
<li>When installing Visual Studios, it is absolutely important you install C++ capabilities, and the vc++ v140 toolchain when selecting features. You will need this for cmake, MSBuild and other commands.</li>
<li>Install <a href="https://sourceforge.net/projects/boost/files/boost-binaries/1.59.0/" rel="nofollow">Boost 1.59.0</a>, ensure to download the installer for  MSVC 14.</li>
</ul>
<h5>Building</h5>
<ul>
<li>Use the start menu or similar to open 'x64 Native Tools Command Prompt for vs2017' command prompt.</li>
<li><code>cd &lt;your_Bitcoinnova-fork_directory&gt;</code></li>
<li><code>mkdir build</code></li>
<li><code>cd build</code></li>
<li><code>cmake -G "Visual Studio 14 Win64" .. -DBOOST_ROOT=D:/Boost/boost_1_59_0</code> (Or your boost installed dir.)</li>
<li><code>MSBuild ByteCoin.sln /p:Configuration=Release</code></li>
<li>At this point, this will create a .sln file in the 'build' directory. Open this .sln in Visual Studios 2017 and click 'Build Solution' under the 'Build' Menu Item.</li>
<li>If all went well, it will complete successfully, and you will find all your binaries in the '..\build\src\Debug' directory, or the '..\build\src\Release' directory if you built with release enabled.</li>
</ul>
<h4>Apple</h4>
<h5>Prerequisites</h5>
<ul>
<li>Install <a href="https://cmake.org/" rel="nofollow">cmake</a>. See <a href="https://stackoverflow.com/questions/23849962/cmake-installer-for-mac-fails-to-create-usr-bin-symlinks" rel="nofollow">here</a> if you are unable call <code>cmake</code> from the terminal after installing.</li>
<li>Install the <a href="http://www.boost.org/" rel="nofollow">boost</a> libraries. Either compile boost manually or run <code>brew install boost</code>.</li>
<li>Install XCode and Developer Tools.</li>
</ul>
<h5>Building</h5>
<ul>
<li><code>git clone https://github.com/Bitcoin-N/Bitcoinnova-fork.git</code></li>
<li><code>cd Bitcoinnova-fork</code></li>
<li><code>mkdir build &amp;&amp; cd $_</code></li>
<li><code>cmake ..</code> or <code>cmake -DBOOST_ROOT=&lt;path_to_boost_install&gt; ..</code> when building<br>
from a specific boost install</li>
<li><code>make</code></li>
</ul>
<p>The binaries will be in <code>./src</code> after compilation is complete.</p>
<h4>Thanks</h4>
<p>Cryptonote Developers, Bytecoin Developers, Forknote Project, TurtleCoin Community, Bitcoinnova Community</p>



---
old method ---

### How To Compile

#### Ubuntu 16.04+ and MacOS 10.10+

There is a bash installation script for Ubuntu 16.04+ and MacOS 10.10+ which can be used to checkout and build the project from source:


On Ubuntu you will be asked for sudo rights to install software. The binaries will be in `./src` after compilation is complete.

This script can be used from inside the git repository to build the project from the checked out source, `./multi_installer.sh`

See the script for more installation details and please consider extending it for your operating system and distribution!

If the script doesn't work for you:

#### Linux


##### Prerequisites

- You will need the following packages: boost (1.55 or higher), rocksdb, cmake, git, gcc (4.9 or higher), g++ (4.9 or higher), make, and python. Most of these should already be installed on your system.
- For example on ubuntu: `sudo apt-get install build-essential python-dev gcc g++ git cmake libboost-all-dev librocksdb-dev`
- If you are using ubuntu and your version of ubuntu doesn't have librocksdb-dev, you can get it from a ppa instead:
```
sudo add-apt-repository ppa:ethcore/ethcore -y
sudo apt-get update
sudo apt-get install librocksdb-dev
```

##### Building

- `git clone https://github.com/Bitcoin-N/Bitcoinnova-fork`
- `cd Bitcoinnova-fork`
- `mkdir build && cd $_`
- `cmake ..`
- `make`

#### Apple

##### Prerequisites

- Install [cmake](https://cmake.org/). See [here](https://stackoverflow.com/questions/23849962/cmake-installer-for-mac-fails-to-create-usr-bin-symlinks) if you are unable call `cmake` from the terminal after installing.
- Install the [boost](http://www.boost.org/) libraries. Either compile boost manually or run `brew install boost`.
- Install XCode and Developer Tools.

##### Building

- `git clone https://github.com/Bitcoin-N/Bitcoinnova-fork`
- `cd Bitcoinnova-fork`
- `mkdir build && cd $_`
- `cmake ..` or `cmake -DBOOST_ROOT=<path_to_boost_install> ..` when building
  from a specific boost install
- `make`

The binaries will be in `./src` after compilation is complete.

#### Windows 10

##### Prerequisites
- Install [Visual Studio 2017 Community Edition](https://www.visualstudio.com/thank-you-downloading-visual-studio/?sku=Community&rel=15&page=inlineinstall)
- When installing Visual Studio, it is **required** that you install **Desktop development with C++** and the **VC++ v140 toolchain** when selecting features. The option to install the v140 toolchain can be found by expanding the "Desktop development with C++" node on the right. You will need this for the project to build correctly.
- Install [Boost 1.59.0](https://sourceforge.net/projects/boost/files/boost-binaries/1.59.0/), ensuring you download the installer for MSVC 14.

##### Building

- From the start menu, open 'x64 Native Tools Command Prompt for vs2017'.
- `cd <your_Bitcoinnova_directory>`
- `mkdir build`
- `cd build`
- Set the PATH variable for cmake: ie. `set PATH="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin";%PATH%`
- `cmake -G "Visual Studio 14 Win64" .. -DBOOST_ROOT=C:/local/boost_1_59_0` (Or your boost installed dir.)
- `MSBuild ByteCoin.sln /p:Configuration=Release /m`
- If all went well, it will complete successfully, and you will find all your binaries in the '..\build\src\Release' directory.
- Additionally, a `.sln` file will have been created in the `build` directory. If you wish to open the project in Visual Studio with this, you can.

#### Thanks
Cryptonote Developers, Bytecoin Developers, Monero Developers, Forknote Project, TurtleCoin Community, Bitcoin nova Community
