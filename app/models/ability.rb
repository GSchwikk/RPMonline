class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. 
    alias_action :update, :destroy, :to => :modify


    if user.role == "pack_owner"
        can :manage, Pack, user_id: user.id
        can :manage, Update, :pack => { :user_id => user.id }
        can :manage, Step, :pack => { :user_id => user.id }
        cannot :manage, Meeting
        cannot :manage, Kpi
    end

    if user.role == "meeting_owner"
        can :manage, Meeting, user_id: user.id
        can :create, Pack
        can :manage, Pack, :meeting => { :user_id => user.id }
        can :manage, Update
        can :manage, Step
        cannot :manage, Division
        cannot :manage, Kpi
    end

    if user.role == "div_owner"
        can :read, Organisation, id: user.organisation_id
        can :manage, Division, user_id: user.id
        can :manage, Meeting, :division => { :user_id => user.id }
        can :manage, Pack 
        can :manage, Update
        can :manage, Step
        cannot :manage, Kpi
    end

    if user.role == "org_owner"
        can :manage, Organisation, id: user.organisation_id
        can :manage, Division, :organisation => { id: user.organisation_id }
        can :manage, Meeting
        can :manage, Pack
        can :manage, Update
        can :manage, Step
        cannot [:destroy,:create], Organisation
    end

    if user.admin?
      can :manage, :all
    end

  end

end
