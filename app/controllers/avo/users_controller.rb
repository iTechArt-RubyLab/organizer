module Avo
  class UsersController < Avo::ResourcesController
    around_action :skip_bullet

    def skip_bullet
      Bullet.enable = false
      yield
    ensure
      Bullet.enable = true
    end
  end
end
