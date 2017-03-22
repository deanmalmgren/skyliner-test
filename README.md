# hello-django

This is a demo Python ([Django](https://www.djangoproject.com)) app you can deploy to [Skyliner](https://www.skyliner.io). Here's a guide to getting started:

[https://www.skyliner.io/help/quick-start](https://www.skyliner.io/help/quick-start)

If you have any trouble, please drop us a line at [support@skyliner.io](mailto:support@skyliner.io?Subject=Help%20with%20hello-django).

The `hello` app is configured as the entrypoint. You can modify this, or use `django-admin startapp` to create new apps here.

## Notes

#### The Docker container
The Docker container runs a [supervisord](http://supervisord.org/) process, which then runs gunicorn to serve the website. Supervisor is used so that you can easily add a worker process to the same container.

Typically, you don't need to run Docker locally. But if you need to debug something, you can use this to build the container:

```
docker build -t dj .
```

And this to run it locally:

```
docker run --rm --tty --interactive --publish 7000:8080 dj
```

#### Security changes
We've disabled the admin interface that is installed by `django-admin startproject` by default. If you want to turn this back on, you can grep the codebase for `admin` and uncomment the relevant lines.

#### Static files
[DJ-Static](https://github.com/kennethreitz/dj-static) is being used to serve static files from gunicorn/Django in production. If you keep this, you should probably [use cloudfront in front of your application](http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-cloudfront-distribution.html) as the Django static file server is not recommended for production use on its own.

Alternatively/additionally, you could put nginx in front of gunicorn, and serve static files from nginx.

See [the Django documentation about static files](https://docs.djangoproject.com/en/1.10/howto/static-files/) for more info.

#### Healthcheck middleware
Use `skyliner.middleware.healthcheck` at the top of your middleware stack for django apps created here. This returns 200 for requests to `/healthcheck/`.

Repo created by [Skyliner](https://www.skyliner.io) app templates at 2017-03-22T14:27:44.674Z