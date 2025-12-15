
"""
octofit_tracker URL Configuration

Codespace URL support:
----------------------
All REST API endpoints are available at:
    https://$CODESPACE_NAME-8000.app.github.dev/api/[component]/
where $CODESPACE_NAME is dynamically set from the environment.
The codespace URL logic is handled in settings.py using the $CODESPACE_NAME environment variable and USE_X_FORWARDED_HOST.
No codespace URL is hardcoded here; see settings.py for details.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
"""

from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views


router = DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'teams', views.TeamViewSet)
router.register(r'activities', views.ActivityViewSet)
router.register(r'workouts', views.WorkoutViewSet)
router.register(r'leaderboard', views.LeaderboardViewSet)


urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include(router.urls)),
    path('api/', include(router.urls)),
]
