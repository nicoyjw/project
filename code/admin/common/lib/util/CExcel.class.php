<?php
	class CExcel
	{
		//@private: Header of excel document (prepended to the rows) 
		var $m_strHeader = "<?xml version=\"1.0\" encoding=\"UTF-8\"?\>
							<Workbook xmlns=\"urn:schemas-microsoft-com:office:spreadsheet\"
							xmlns:x=\"urn:schemas-microsoft-com:office:excel\"
							xmlns:ss=\"urn:schemas-microsoft-com:office:spreadsheet\"
							xmlns:html=\"http://www.w3.org/TR/REC-html40\">";
		
		//@private: Footer of excel document (appended to the rows) 
		var $m_strFooter = "</Workbook>";
		
		//@private: Save WorkSheets Info
		//eg: { {'strTitle => 'tables', 'arrLines' => {'<Cell><Data ss:Type=\"String\"> andylin </Data></Cell>\n',...}}, ...}
		var $m_arrWorkSheets = array();		
		
		function __construct()
		{
		}
		
		function __destruct()
		{
		}
		
		//@private: Set the worksheet title
		//Checks the string for not allowed characters (:\/?*),cuts it to maximum 31 characters and set the title.
		//Damn why are not-allowed chars nowhere to be found? Windows help's no help… 
		function GetSheetTitle($strTitle)
		{
			$strTitle = preg_replace("/[\\\|:|\/|\?|\*|\[|\]]/", "", $strTitle);
			$strTitle = substr($strTitle, 0, 31);
			
			return $strTitle;
		}
	
		//@private: Add a single row to the $document string 
		function AddRow($arrInfo)
		{
			// initialize all cells for this row
			$strCells = "";
			
			//foreach key -> write value into cells
			foreach ($arrInfo as $key => $val)
			{
				//加个字符串与数字的判断,避免生成的 excel 出现数字以字符串存储的警告
				if (is_numeric($val))
				{
					//防止首字母为0时生成 excel 后0丢失
					if (0 == substr($val, 0, 1))
					{
						$strCells .= "<Cell><Data ss:Type=\"String\">" . $val . "</Data></Cell>\n";
					}
					else
					{
						$strCells .= "<Cell><Data ss:Type=\"Number\">" . $val . "</Data></Cell>\n";
					}
				}
				else
				{
					$strCells .= "<Cell><Data ss:Type=\"String\">" . $val . "</Data></Cell>\n";
				}
			}
			
			//transform $cells content into one row
			$strRow = "<Row>\n" . $strCells . "</Row>\n";
			
			return $strRow;
		}
		
		//@private: Add an array to the document
		function AddMutiRow($arrInfos)
		{			
			foreach ($arrInfos as $key => $val)
			{
				$strRow = $this->AddRow($val);
				$arrLines[] = $strRow;
			}
			
			return $arrLines;
		}
		
		//@public: Addd a Worksheet
		function AddWorksheet($arrSheet)
		{			
			if (!$arrSheet['strTitle'])
			{
				return false;
			}
			
			$strTitle = $this->GetSheetTitle($arrSheet['strTitle']);			
			
			if (!$arrSheet['arrLines'])
			{
				return false;
			}
			
			$arrLines = $this->AddMutiRow($arrSheet['arrLines']);			
			$arrSheet = array('strTitle' => $strTitle, 'arrLines' => $arrLines);
			
			$this->m_arrWorkSheets[] = $arrSheet;
		}
		
		//@public: Add Mutiply Worksheets
		function AddMutiWorksheet($arrSheets)
		{
			foreach ($arrSheets as $key => $val)
			{
				$arrSheet = $this->AddWorksheet($val);				
			}			
		}				
		
		//@public: Generate the excel file
		//Finally generates the excel file and uses the header() function to deliver it to the browser. 
		function SaveExcel($strFile)
		{
			//deliver header (as recommended in php manual)
			header("Content-Type: application/vnd.ms-excel; charset=UTF-8");
			header("Content-Disposition: inline; filename=\"" . $strFile . ".xls\"");
			
			//print out document to the browser need to use stripslashes for the damn ">"
			$strXml = stripslashes($this->m_strHeader);
			
			foreach ($this->m_arrWorkSheets as $key => $val)
			{
				//array('strTitle' => $strTitle, 'arrLines' => $arrLines);				
				$strXml .= "\n<Worksheet ss:Name=\"" . $val['strTitle'] . "\">\n<Table>\n";	
				$strXml .= "<Colum ss:Index=\"1\" ss:AutoFitWidth=\"0\" ss:width=\"110\" />\n";
				$strXml .= implode("\n", $val['arrLines']);
				$strXml .= "</Table>\n</Worksheet>\n";				
			}
			
			$strXml .= $this->m_strFooter;
			echo $strXml;
		}
	}
?>