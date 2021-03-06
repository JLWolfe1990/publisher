class Ability
  include CanCan::Ability

  def initialize(user)
    can [:welcome, :read], Article
    can :read, TopicRequest
    can [:show, :create], Search
    can :subscribe, User

    return unless user

    can [:create, :new], Comment
    can :destroy, Comment, user_id: user.id
    can [:create, :upvote, :downvote], TopicRequest
    give_contributor_permissions(user) if user.contributor? || user.admin?
    give_admin_permissions if user.admin?
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end

  def give_admin_permissions
    can :destroy, Comment
    can :manage, Article
  end

  def give_contributor_permissions(user)
    can :create, Article
    can :update, Article, user_id: user.id
  end
end
