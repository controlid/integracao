/**
 ******************************************************************************
 * @file    satidlib_conf.h
 * @author  Dimitri Marques - dimitri@controlid.com.br
 * @version v0.0.0
 * @date    31 de ago de 2017
 * @brief
 ******************************************************************************
 * @attention
 *
 * <h2><center> COPYRIGHT &copy; 2017 Control iD </center></h2>
 * <h2><center>            All Rights Reserved &reg;          </center></h2>
 *
 * Licensed under Control iD Firmware License Agreement, (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *
 *        http://www.controlid.com.br/licenses
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 ******************************************************************************
 */
#ifndef SATIDLIBCONF_H_
#define SATIDLIBCONF_H_

#if defined(_WIN32) || defined(__CYGWIN__)
#define WIN32_AVAILABLE 1
#elif defined(__unix__) || defined(__MACH__) || defined(__NetBSD__) || defined(__sun)
#define UNIX_AVAILABLE  1
#endif

#if defined(WIN32_AVAILABLE) && defined(CALL_CONV_STDCALL)
#define STDCALL __stdcall 
#else 
#define STDCALL 
#endif

#if defined(WIN32_AVAILABLE) && !defined(DOXYGEN_PROCESSING)

#ifdef SATIDLIB_EXPORTS
#define SATIDLIB_API __declspec(dllexport)
#else
#define SATIDLIB_API __declspec(dllimport)
#endif

#define IDSALIB_INIT
#define IDSALIB_FINIT

#elif defined (UNIX_AVAILABLE)


#ifdef SATIDLIB_EXPORTS
#define SATIDLIB_API __attribute__ ((visibility ("default")))
#define IDSALIB_INIT __attribute__((constructor))
#define IDSALIB_FINIT __attribute__((destructor))
#else
#define SATIDLIB_API
#define IDSALIB_INIT
#define IDSALIB_FINIT
#endif /* UNIX_AVAILABLE */

#else
#define SATIDLIB_API
#define IDSALIB_INIT
#define IDSALIB_FINIT
#endif


#include <stdint.h>

#endif /* SATIDLIBCONF_H_ */
