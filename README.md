# 寶卡卡搜尋器

快速搜尋是否為寶系列建商，
『先生先生～這個建案很適合您，只要OOO，買到賺到！』
『請問是哪個建商的呢？』
『是XX!』

# 資料後端

我很懶得去弄一個真的後端伺服器，所有資料都是在『[你今天寶咖咖了嗎？](https://isthisbaokaka.wordpress.com/)』這個WordPress.com網誌上。  
另外我也沒高竿到寫web scrapper自動幫我爬來這些資料，所有資料都是人工整理，詳情請見[上述網誌](https://isthisbaokaka.wordpress.com/)，
歡迎各方大德貢獻資料。

# 開發
Prerequisities:

* [elm](https://guide.elm-lang.org/install.html)
* GNU make

編譯與執行：

1. `make`: 編譯出`is-this-baokaka.js`，開啟根目錄下的`index.html`即可使用
1. `make run`: 編譯並開啟`index.html`。因為我用了OSX的`open`，非OSX會無法使用
