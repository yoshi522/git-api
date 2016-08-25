
#line-api

This is a api for line internship 2016, sarry team with using line bot.

###Usage

Use get http request method for this base url  
`https://gif-api.herokuapp.com/v1`


###Endpoint
for gif  
`curl -X GET https://gif-api.herokuapp.com/v1/gif`  
if you want to see preview, use `https://gif-api.herokuapp.com/v1/gif/preview` instead.

for image  
`curl -X GET https://gif-api.herokuapp.com/v1/img`  
if you want to see preview, use `https://gif-api.herokuapp.com/v1/img/preview` instead.

for gal text converter  
`curl -X GET https://gif-api.herokuapp.com/v2/gal/text=[sentence]`  
You can put sentence in Japanese, then you get converted sentence like as a gal (japanese young female)

the basic response:
```
{
    meta: {
        status: 200
    },
    data: {
        id: 7,
        link: "https://s3-ap-northeast-1.amazonaws.com/line-bot-2016/gif/git-7.gif"
    }
}
```


###License

Copyright (c) 2016 Yoshihito Takashiba
