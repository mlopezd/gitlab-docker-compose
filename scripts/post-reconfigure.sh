#!/bin/bash
set -e

gitlab-rails runner - <<EOS
# - Disable signup
ApplicationSetting.last.update(signup_enabled: false)

# - Set Monday as first day of week
ApplicationSetting.last.update(first_day_of_week: 1)
EOS