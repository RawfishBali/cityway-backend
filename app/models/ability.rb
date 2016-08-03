class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? :super_admin
      can :manage, :all
    elsif user.has_role? :city_admin
      can :manage, City
    elsif user.has_role? :retail_admin
      # can :read, Forum
      # can :manage, Forum if user.has_role?(:manager, Forum)
      # can :write, Forum, :id => Forum.with_role(:moderator, user).pluck(:id)
    end
  end
end
