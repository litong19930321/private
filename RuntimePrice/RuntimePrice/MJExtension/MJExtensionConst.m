#ifndef __MJExtensionConst__M__
#define __MJExtensionConst__M__

#import <Foundation/Foundation.h>

/**
 *  成员变量类型（属性类型） 
 *  后面对应的值 是通过 property_getAttributes得到属性的类型后 截取 得来的
 */
NSString *const MJPropertyTypeInt = @"i";
NSString *const MJPropertyTypeShort = @"s";
NSString *const MJPropertyTypeFloat = @"f";
NSString *const MJPropertyTypeDouble = @"d";
NSString *const MJPropertyTypeLong = @"l";
NSString *const MJPropertyTypeLongLong = @"q";
NSString *const MJPropertyTypeChar = @"c";
NSString *const MJPropertyTypeBOOL1 = @"c";
NSString *const MJPropertyTypeBOOL2 = @"b";
NSString *const MJPropertyTypePointer = @"*";

NSString *const MJPropertyTypeIvar = @"^{objc_ivar=}";
NSString *const MJPropertyTypeMethod = @"^{objc_method=}";
NSString *const MJPropertyTypeBlock = @"@?";
NSString *const MJPropertyTypeClass = @"#";
NSString *const MJPropertyTypeSEL = @":";
NSString *const MJPropertyTypeId = @"@";

#endif
