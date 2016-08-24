
#gif-api

you can get random images gif through this api.

###Usage

Use get method for this url
`https://gif-api.herokuapp.com/v1/gif`

and this response like this:
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

if you want to see preview, use `https://gif-api.herokuapp.com/v1/gif/preview` instead.



###License

Copyright (c) 2016 Yoshihito Takashiba
