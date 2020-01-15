
--------------------------------
-- @module Armature
-- @extend IAnimatable
-- @parent_module 

--------------------------------
-- @function [parent=#Armature] getBone 
-- @param self
-- @param #string str
-- @return Bone#Bone ret (return value: dbs.Bone)
        
--------------------------------
-- @function [parent=#Armature] getAnimation 
-- @param self
-- @return Animation#Animation ret (return value: dbs.Animation)
        
--------------------------------
-- @overload self, dbs.Bone, string         
-- @overload self, dbs.Bone         
-- @function [parent=#Armature] addBone
-- @param self
-- @param #dbs.Bone bone
-- @param #string str

--------------------------------
-- @overload self, string         
-- @overload self, dbs.Slot         
-- @function [parent=#Armature] removeSlot
-- @param self
-- @param #dbs.Slot slot

--------------------------------
-- @function [parent=#Armature] getSlot 
-- @param self
-- @param #string str
-- @return Slot#Slot ret (return value: dbs.Slot)
        
--------------------------------
-- @overload self, string         
-- @overload self, dbs.Bone         
-- @function [parent=#Armature] removeBone
-- @param self
-- @param #dbs.Bone bone

--------------------------------
-- @function [parent=#Armature] getBones 
-- @param self
-- @return array_table#array_table ret (return value: array_table)
        
--------------------------------
-- @function [parent=#Armature] getDisplay 
-- @param self
-- @return void#void ret (return value: void)
        
--------------------------------
-- @function [parent=#Armature] addSlot 
-- @param self
-- @param #dbs.Slot slot
-- @param #string str
        
--------------------------------
-- @function [parent=#Armature] getSlotByDisplay 
-- @param self
-- @param #void void
-- @return Slot#Slot ret (return value: dbs.Slot)
        
--------------------------------
-- @function [parent=#Armature] getBoneByDisplay 
-- @param self
-- @param #void void
-- @return Bone#Bone ret (return value: dbs.Bone)
        
--------------------------------
-- @function [parent=#Armature] getArmatureData 
-- @param self
-- @return ArmatureData#ArmatureData ret (return value: dbs.ArmatureData)
        
--------------------------------
-- @overload self, string         
-- @overload self         
-- @function [parent=#Armature] invalidUpdate
-- @param self
-- @param #string str

--------------------------------
-- @function [parent=#Armature] getEventDispatcher 
-- @param self
-- @return IEventDispatcher#IEventDispatcher ret (return value: dbs.IEventDispatcher)
        
--------------------------------
-- @function [parent=#Armature] getBoundingBox 
-- @param self
-- @return Rectangle#Rectangle ret (return value: dbs.Rectangle)
        
--------------------------------
-- @function [parent=#Armature] replaceSlot 
-- @param self
-- @param #string str
-- @param #string str
-- @param #dbs.Slot slot
        
--------------------------------
-- @function [parent=#Armature] getSlots 
-- @param self
-- @return array_table#array_table ret (return value: array_table)
        
--------------------------------
-- @function [parent=#Armature] sortSlotsByZOrder 
-- @param self
        
--------------------------------
-- @function [parent=#Armature] dispose 
-- @param self
        
--------------------------------
-- @function [parent=#Armature] advanceTime 
-- @param self
-- @param #float float
        
--------------------------------
-- @function [parent=#Armature] Armature 
-- @param self
-- @param #dbs.ArmatureData armaturedata
-- @param #dbs.Animation animation
-- @param #dbs.IEventDispatcher ieventdispatcher
-- @param #void void
        
return nil
