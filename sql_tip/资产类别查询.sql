SELECT A.DESCRIPTION 资产类别,
       A.SEGMENT1    大类代码,
       A.ATTRIBUTE1  大类名称,
       A.SEGMENT2    中类代码,
       A.ATTRIBUTE2  中类名称,
       A.SEGMENT3    小类代码,
       A.ATTRIBUTE3  小类名称
  FROM FA_CATEGORIES_VL A;
  
--select * from   FA_CATEGORIES_TL;
