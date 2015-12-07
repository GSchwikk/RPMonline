class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. 

    if user.admin?
      can :manage, :all
    else
      #can :read, :all
    end

    if user.role == "pack_owner"
        can :manage, Pack, user_id: user.id
        can :manage, Update, :pack => { :user_id => user.id }
        can :manage, Step, :pack => { :user_id => user.id }
        cannot :manage, Meeting
    end

    if user.role == "meeting_owner"
        can :manage, Meeting, user_id: user.id
        can :manage, Pack, :meeting => { :user_id => user.id }
        can :manage, Update
        can :manage, Step
        #cannot :manage, Division
    end

  end

end
