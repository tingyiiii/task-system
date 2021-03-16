# 任務管理系統
- 可新增自己的任務
- 使用者登入後，只能看見自己建立的任務
- 可設定任務的開始及結束時間
- 可設定任務的優先順序（高、中、低）
- 可設定任務目前的狀態（待處理、進行中、已完成）
- 可依狀態篩選任務
- 可以任務的標題、內容進行搜尋
- 可為任務加上分類標籤
- 任務列表，並可依優先順序、開始時間及結束時間等進行排序

***
## Ruby & Rails version
- Ruby: 2.7.2
- Rails: 6.0.3

***
## model ER圖
![model ER圖](https://i.imgur.com/x2iJeoP.png)

***
## table schema

### users
  |Column|Data Type|
  |--|--|
  |id|*int*| 
  |email|*str*| 
  |password|*str*| 
  |name|*str*| 
  |role|*str*| 

### tasks
  |Column|Data Type|
  |--|--|
  |id|*int*| 
  |title|*str*| 
  |start_time|*str*| 
  |end_time|*str*| 
  |priority|*int*| 
  |status|*int*| 
  |discription|*str*| 
  |user_id|*str*| 

### tags
  |Column|Data Type|
  |--|--|
  |id|*int*| 
  |name|*str*| 

### task_tags
  |Column|Data Type|
  |--|--|
  |id|*int*| 
  |task_id|*int*| 
  |tag_id|*int*| 

***
## Deploy the app to Heroku
1. Create a Heroku account
2. Download & install the heroku CLI
3. Run `$ heroku create`, you could assign the name for app by run `$ heroku create (your app name)` instead
4. Run `$ git push heroku master` to push your code to heroku from master branch, or run `$ git push heroku (your branch name):master` to push another branch
5. Run `$ heroku run rails db:migrate` if this is your first time pushing code


