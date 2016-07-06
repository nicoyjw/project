<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 客户帮助操作类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

class ModelHelps extends Model {
    
    /**
     * 构造函数
     *
     * @param object $query
     */
    function __construct($query=null) {
        parent::__construct($query);
        $this->tableName = CFG_DB_PREFIX . 'erp_faq_common';
        $this->keywordtableName = CFG_DB_PREFIX . 'erp_faq_keyword_common';
        $this->primaryKey = 'id';
    }
    
    function getHelpsList($from,$to,$type){
                    
        $query = ModelUser::connectErpDb();         
        $query->open('select * from '.$this->tableName.' where type = '.$type.' order by '.$sort.$this->primaryKey.' desc',$from,$to);
        $result = array();
        while ($rs = $query->next()) {
            $result[] = $rs;
        }
        return $result;
    }
}
?>