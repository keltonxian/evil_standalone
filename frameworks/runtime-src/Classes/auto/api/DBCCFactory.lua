
--------------------------------
-- @module DBCCFactory
-- @extend BaseFactory
-- @parent_module 

--------------------------------
-- @overload self, string, string         
-- @overload self, string         
-- @overload self, string, string, string, string, string         
-- @function [parent=#DBCCFactory] buildArmatureNode
-- @param self
-- @param #string str
-- @param #string str
-- @param #string str
-- @param #string str
-- @param #string str
-- @return DBCCArmatureNode#DBCCArmatureNode ret (retunr value: dbs.DBCCArmatureNode)

--------------------------------
-- @function [parent=#DBCCFactory] hasDragonBones 
-- @param self
-- @param #string str
-- @param #string str
-- @param #string str
-- @return bool#bool ret (return value: bool)
        
--------------------------------
-- @function [parent=#DBCCFactory] loadTextureAtlas 
-- @param self
-- @param #string str
-- @param #string str
-- @return ITextureAtlas#ITextureAtlas ret (return value: dbs.ITextureAtlas)
        
--------------------------------
-- @function [parent=#DBCCFactory] refreshAllTextureAtlasTexture 
-- @param self
        
--------------------------------
-- @function [parent=#DBCCFactory] refreshTextureAtlasTexture 
-- @param self
-- @param #string str
        
--------------------------------
-- @function [parent=#DBCCFactory] loadDragonBonesData 
-- @param self
-- @param #string str
-- @param #string str
-- @return DragonBonesData#DragonBonesData ret (return value: dbs.DragonBonesData)
        
--------------------------------
-- @function [parent=#DBCCFactory] destroyInstance 
-- @param self
        
--------------------------------
-- @function [parent=#DBCCFactory] getInstance 
-- @param self
-- @return DBCCFactory#DBCCFactory ret (return value: dbs.DBCCFactory)
        
--------------------------------
-- @overload self, string, string         
-- @overload self, string         
-- @overload self, string, string, string, string, string         
-- @function [parent=#DBCCFactory] buildArmature
-- @param self
-- @param #string str
-- @param #string str
-- @param #string str
-- @param #string str
-- @param #string str
-- @return DBCCArmature#DBCCArmature ret (retunr value: dbs.DBCCArmature)

--------------------------------
-- @function [parent=#DBCCFactory] DBCCFactory 
-- @param self
        
return nil
