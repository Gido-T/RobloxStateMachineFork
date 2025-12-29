local Transition = require(script.Parent.Transition)
local mergeTables = require(script.Parent.Parent.Functions.mergeTables)

local State = {}
State.__index = State
State.Type = "State"

State.Name = "" :: string
State.Transitions = {} :: {Transition.Transition}
State.Data = {} :: {[string]: any}
State._transitions = {} :: {[string]: Transition.Transition}
State._changeState = nil :: (newState: string)->()?
State._changeData = nil :: (index: string, newValue: any)-> ()?
State._getState = nil :: (index: string, newValue: any)-> string

function State.new(stateName: string?): State
    local self = setmetatable({}, State)
    
    self.Name = stateName or ""
    self.Transitions = {}

    return self
end


function State:Extend(stateName: string): State
    return mergeTables(State.new(stateName), self)
end

function State:ChangeState(newState: string): ()
    if not self._changeState then
        return
    end

    self._changeState(newState)
end

function State:GetState(): string
    if not self._getState then
        return ""
    end

    return self._getState()
end

function State:ChangeData(index: string, newValue: any): ()
    if not self._changeData then
        return
    end

    self._changeData(index, newValue)
end

function State:OnInit(_data: {[string]: any}): ()

end

function State:CanChangeState(_targetState: string): boolean
    return true
end

function State:OnDataChanged(_data: {[string]: any}, _index: any, _value: any, _oldValue: any): ()

end

function State:OnEnter(_data: {[string]: any}): ()

end

function State:OnHeartbeat(_data: {[string]: any}, _deltaTime: number): ()

end

function State:OnLeave(_data: {[string]: any}): ()

end

function State:OnDestroy(): ()
    
end

export type State = typeof(State)

return setmetatable(State, {
    __call = function(_, properties): State
        return State.new(properties)
    end
})