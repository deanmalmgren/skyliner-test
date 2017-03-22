from django.http import HttpResponse

def healthcheck(get_response):
    """
    Middleware that implements a simple healthcheck. The healthcheck
    needs to be middleware so that it is processed before the ALLOWED_HOSTS
    check. Amazon's load balancer requests the healthcheck with no HOST header.
    """
    def hc(request):
        if request.path == '/healthcheck/':
            return HttpResponse('ok')
        return get_response(request)
    return hc
