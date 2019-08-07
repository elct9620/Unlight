Unlight
===

這是用來打包 `Unlight.swf` 的特殊版本，目前還不穩定以及缺少部分檔案。

## 環境需求

* Docker
* Docker Compose
* make

## 獲取原始碼

```bash
git clone git@github.com:elct9620/Unlight.git -b docker
cd Unlight
git submodule update --recursive
```

### 字體檔

繁體中文版會需要下面這兩款免費字型打包，請自行 Google 放到 `fonts/` 資料夾。

* wt004.ttf
* cwming.ttf
* nbr.ttf

> `nbr.ttf` 是叫做 `Bradley_Gratis.ttf` 的字體，官方有改過加入部分文字。

## 客戶端

目前預設是以繁體中文的環境為目標，已經先上了各種補丁，待穩定後需要將補丁清除以原始的狀態生成。

```bash
make build client
```

過程中會啟動 MySQL 伺服器以及 Memcached 來讀取遊戲資料，這部分是因為生成客戶端時需要從伺服器讀取一些固定數值直接暫存到客戶端上。

## 伺服端

```bash
# 啟動
make start

# 停止
make stop
```

## 測試

```bash
cd dist
ruby -run -e httpd
```

這會在本機打開一個網頁伺服器，可以用 `http://localhost:8080` 開啟測試。

> 請自行複製 `app/client/public` 裡面的 XML 檔案到 `dist/public` 並且改為你的伺服器配置。
