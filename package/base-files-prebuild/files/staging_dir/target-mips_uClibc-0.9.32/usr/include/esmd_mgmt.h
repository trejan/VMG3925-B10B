/******************************************************************************/
/*
*  Copyright (C) 2012 ZyXEL Communications, Corp.
*  All Rights Reserved.
*
* ZyXEL Confidential; Need to Know only.
* Protected as an unpublished work.
*
* The computer program listings, specifications and documentation
* herein are the property of ZyXEL Communications, Corp. and
* shall not be reproduced, copied, disclosed, or used in whole or
* in part for any reason without the prior express written permission of
* ZyXEL Communications, Corp.
*/
/******************************************************************************/

#ifndef _ESMD_MGMT_H_
#define _ESMD_MGMT_H_




/**********************
*	Global Variable
**********************/


/**********************
*	Function List
**********************/
void mgmtNatDetect(char *msg);
void mgmtNatClear(void);
void mgmtConnectUpdate(char *msg);
void tr64LanDeviceUpdate( void );

#endif /*_ESMD_MGMT_H_*/


