Ext.namespace('Ext.ux.form');

/**
 * FCKeditor 初始配置信息
 * 
 * @type {Object}
 */
var oFCKeditorOptions = {
	BasePath : '/erp/js/FCKeditor/',
	Config : {
		BaseHref : window.location,
		SkinPath : '/erp/js/FCKeditor/editor/skins/office2003/',
		ProcessHTMLEntities : true,
		ProcessNumericEntities : false,
		ToolbarStartExpanded : true,
		LinkBrowser : true,
		ImageBrowser : true,
		FlashBrowser : true,
		LinkUpload : true,
		ImageUpload : true,
		FlashUpload : true
	},
	ToolbarSet : 'Default'
};

/**
 * Ext FCKeditor
 * 
 * @param {Object}
 *            config 配置信息
 */
Ext.ux.form.FCKeditor = function(config) {
	this.config = config;
	Ext.ux.form.FCKeditor.superclass.constructor.call(this, config);
	/**
	 * 通知FCKeditor是否实例化 
	 * notice the component's FCKeditor instance inited
	 * @type Boolean
	 */
	this.instanceLoaded = false;
	/**
	 * 实例值
	 * the component's FCKeditor instance value
	 * @type String
	 */
	this.instanceValue = '';
	/**
	 * 组件的FCKeditor实例
	 * @type {FCKeditor}
	 */
	this.editorInstance = undefined;
};
/**
 * Ext FCKeditor
 * 
 * @class Ext.ux.form.FCKeditor
 * @extends Ext.form.TextArea
 */
Ext.extend(Ext.ux.form.FCKeditor, Ext.form.TextArea, {
			/**
			 * 初始化事件
			 */
			initEvents : function() {
				this.on('destroy', function() {
							if (typeof this.editorInstance != 'undefined') {
								delete this.editorInstance;
							}
						});
			},
			onRender : function(ct, position) {
				if (!this.el) {
					this.defaultAutoCreate = {
						tag : "textarea",
						style : "width:100px;height:60px;",
						autocomplete : "off"
					};
				}
				Ext.form.TextArea.superclass.onRender.call(this, ct, position);
				this.hideMode = "visibility";
				//this.hidden = true;
				if (this.grow) {
					this.textSizeEl = Ext.DomHelper.append(document.body, {
								tag : "pre",
								cls : "x-form-grow-sizer"
							});
					if (this.preventScrollbars) {
						this.el.setStyle("overflow", "hidden");
					}
					this.el.setHeight(this.growMin);
				}
				setTimeout("loadFCKeditor('" + this.id + "'," + this.config.height + ");", 200); // Change
			},
			/**
			 * 设置是否已经加载过此控件
			 * set FCKeditor instance is inited
			 * @param {Boolean} v
			 */
			setIsLoaded : function(v) {
				this.instanceLoaded = v;
			},
			/**
			 * 获取是否已实例化过此控件
			 * get FCKeditor instance is inited
			 * @return {Boolean}
			 */
			getIsLoaded : function() {
				return this.instanceLoaded;
			},
			/**
			 * 
			 * @param {String} value
			 */
			setValue : function(value) {
				this.instanceValue = value;
				if (this.instanceLoaded) {
					this.FCKeditorSetValue(value); // Change this.name
				}
				Ext.form.TextArea.superclass.setValue.apply(this, [value]);
			},
			/**
			 * 
			 * @return {String}
			 */
			getValue : function() {
				if (this.instanceLoaded) {
					value = this.FCKeditorGetValue(); // Change this.name to this.id
					Ext.form.TextArea.superclass.setValue.apply(this, [value]);
					return Ext.form.TextArea.superclass.getValue.call(this); // Change getValue(this) to
				} else {
					return this.instanceValue;
				}
			},
			/**
			 * 
			 * @return {String}
			 */
			getRawValue : function() {
				if (this.instanceLoaded) {
					value = this.FCKeditorGetValue(); // Change this.name to this.id
					Ext.form.TextArea.superclass.setRawValue.apply(this, [value]);
					return Ext.form.TextArea.superclass.getRawValue.call(this); // Change getValue(this) to
				} else {
					return this.instanceValue;
				}
			},
			/**
			 * 设置FCKeditor实例的值
			 * @param {String} value
			 */
			FCKeditorSetValue : function(value) {
				if(this.instanceLoaded == false){
					return;
				}
				// fix IE No Permission Denied errors
				var runner = new Ext.util.TaskRunner();
				var task = {
					run : function() {
						try {
							var editor = this.editorInstance; // update var editor
							if (editor.EditorDocument.body) {
								editor.SetData(value);
								runner.stop(task);
							}
						} catch (ex) {
							//Ext.logf('调试信息(info)：{0}', ex);
						}
					},
					interval : 100,
					scope : this
				};
				runner.start(task); // end fix
			},
			/**
			 * 获取FCKeditor实例的值
			 * @return {String}
			 */
			FCKeditorGetValue : function() {
				var data = '';
				if(this.instanceLoaded == false){
					return data;
				}
				data = this.editorInstance.GetData();				
				return data;
			}
		});
//Ext.reg('fckeditor', Ext.ux.form.FCKeditor);

/**
 * 实例化FCKeditor
 * 
 * @param {String}
 *            element el id
 * @param {Number}
 *            height
 */
function loadFCKeditor(element, height) {
	var oFCKeditor = new FCKeditor(element);
	oFCKeditor.BasePath = oFCKeditorOptions.BasePath;
	oFCKeditor.ToolbarSet = oFCKeditorOptions.ToolbarSet;
	oFCKeditor.Config = oFCKeditorOptions.Config;
	oFCKeditor.Height = height;
	oFCKeditor.ReplaceTextarea();
}
/**
 * FCKeditor API: 当FCKeditor实例化完成时执行
 * 
 * @param {FCKeditor} editorInstance
 */
function FCKeditor_OnComplete(editorInstance) {
	/**
	 * @type {Ext.ux.form.FCKeditor}
	 */
	var activeEditor = Ext.getCmp(editorInstance.Name);
	activeEditor.editorInstance = editorInstance;
	activeEditor.instanceLoaded = true;
	activeEditor.FCKeditorSetValue(activeEditor.instanceValue);
	editorInstance.Events.AttachEvent('OnBlur', FCKeditor_OnBlur);
	editorInstance.Events.AttachEvent('OnFocus', FCKeditor_OnFocus);
}

function FCKeditor_OnBlur(editorInstance) {
	editorInstance.ToolbarSet.Collapse();
}

function FCKeditor_OnFocus(editorInstance) {
	editorInstance.ToolbarSet.Expand();
}

