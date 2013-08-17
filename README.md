dotfiles
========
在 github 上有許多神人 share 自己的 dotfiles 讓大家 fork/clone. 其實我也建議大家可以 create 一份屬於自己喜歡的設定。在我的 dotfiles 裡有 bash/zsh 的 shell 環境設定，亦有 tmux/screen 的設定檔和 git 設定檔。

1. 先在 github 上 fork [farrrr/dotfiles](https://github.com/farrrr/dotfiles) 這個專案到你的 github 帳號裡
2. 將你的 dotfiles repo clone 至本機端，請將 `git@github.com:farrrr/dotfiles.git` 替換成你自己的 repo 網址.

        $ git clone git@github.com:farrrr/dotfiles.git
  
3. ***必要!!*** 先將 `.gitconfig` 中的 email & name 欄位改成你自己的資訊，不然之後 commit 都會變成我的名字(羞)
4. 你可以依照你的需求去更動你想設定或者是整合你現在的設定檔。
5. `git commit` & `git push` 把你的更動送回你的 git/github repo 中，這樣你就成功的製作出你自己的 dotfiles repo.
6. 當你在任何機器上使用，只要 `git clone` 然後執行目錄下的 `install.sh`，就會將設定檔安裝至你的`$HOME`目錄中，重新登入，或者是重新 source 就可以看到新的環境了。（原本的設定檔會幫你備份成 `.rcfile.$Y$M$D` 的檔案

#### *bash/zsh*
在我的 dotfiles 中，我將兩個 shell 共同會用到的一些設定獨立出來，這樣可以只需要修改一個檔案，這樣就可以兩個 shell 都可以共用.

1. `.bashrc` & `.bash_profile`  
bash shell 的相關設定都在此
2. `.bash_prompt`  
我將 bash 的 prompt 獨立成一個檔案，如果你對於 prompt 的 style 有所不滿，盡管客製化成你想要的 style. 裡面也有 prompt 參數與色碼的註解，歡迎參考使用。
3. `.zshrc`  
zsh shell 的相關設定，因為我是 extend oh-my-zsh，如果你是要使用的話也要先安裝 [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh.git)。請記得將 `.zshrc` 中的 `ZSH=$HOME/shell/src/myzsh` 改成你自己的 `oh-my-zsh` 路徑
4. `.aliases`  
所有 aliases 設定都寫在此，bash/zsh 都會讀取這個檔案。裡面有依照不同 OS (Linux/OSX/FreeBSD) 有作不同的 aliases 設定
5. `.exports`  
所有 exports 設定都寫在此，bash/zsh 都會讀取這個檔案。
6. `.functions`  
所有 customize function 都寫在這裡面，bash/zsh 都會讀取這個檔案。
7. `.path` & `.extra`  
這兩個檔案在 repo 中不存在，但是用途是在於，如果你有針對不同的機器，有比較特別的 path & 其他設定，但不想 commit 到 repo 中的話，就把他寫在這兩個檔案中，當檔案存在，bash/zsh 會自動讀取進來。***注意*** 請將此兩個檔案放在你的`$HOME` 下

#### *tmux/screen*
在遠端管理機器，tmux 跟 screen 這種 Terminal Multiplexer 是不可或缺的，現在都是用 tmux 了，screen 算是已經被丟掉了..XD.

1. `.tmux.conf` & `.tmux`  
在裡面有許多我自己常用的設定及美化的 style 都設定好了，你可以直接就可以使用，快速鍵也請直接看設定檔就知道了。我有額外 source powerline. 讓我的 tmux 更美化，不過這部份需要額外安裝 [Powerline](https://powerline.readthedocs.org/en/latest/)。教學我這邊就不寫了，自己參照前面的網址去作設定吧。在 `.tmux.conf` 中也要把 `source-file ~/shell/powerline/powerline.conf` 路徑換成你的 `powerline.conf` 路徑  
如果你在 Terminal 中 statusline 有看見亂碼，不用緊張，這是正常的，請先安裝 [Powerline 字型檔](https://github.com/Lokaltog/powerline-fonts)，在本機裝，不是遠端，然後你的 Terminal 換成你安裝的字型即可。
2. `.screenrc`
也有基本的 styles，只是沒有像 tmux 一樣這麼 fancy。唯一 screen 比 tmux 強的就是 idle 時間久了就會自動鎖窗是唯一贏過 tmux 的了。
