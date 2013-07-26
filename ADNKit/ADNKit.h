/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <ADNKit/ANKResourceMap.h>

#import <ADNKit/ANKClient.h>
#import <ADNKit/ANKClient+ANKUser.h>
#import <ADNKit/ANKClient+ANKPost.h>
#import <ADNKit/ANKClient+ANKPostStreams.h>
#import <ADNKit/ANKClient+ANKFile.h>
#import <ADNKit/ANKClient+ANKPlace.h>
#import <ADNKit/ANKClient+ANKChannel.h>
#import <ADNKit/ANKClient+ANKMessage.h>
#import <ADNKit/ANKClient+ANKStream.h>
#import <ADNKit/ANKClient+ANKInteraction.h>
#import <ADNKit/ANKClient+ANKExploreStream.h>
#import <ADNKit/ANKClient+ANKFilter.h>
#import <ADNKit/ANKClient+ANKTokenStatus.h>
#import <ADNKit/ANKClient+ANKStreamMarker.h>

#import <ADNKit/ANKResource.h>
#import <ADNKit/ANKAnnotatableResource.h>
#import <ADNKit/ANKAnnotationReplacement.h>

#import <ADNKit/ANKUser.h>
#import <ADNKit/ANKUserCounts.h>
#import <ADNKit/ANKUserDescription.h>

#import <ADNKit/ANKChannel.h>
#import <ADNKit/ANKChannelCounts.h>
#import <ADNKit/ANKACL.h>

#import <ADNKit/ANKPlace.h>
#import <ADNKit/ANKPlaceCategory.h>

#import <ADNKit/ANKPost.h>
#import <ADNKit/ANKMessage.h>
#import <ADNKit/ANKFile.h>
#import <ADNKit/ANKStream.h>
#import <ADNKit/ANKFilter.h>
#import <ADNKit/ANKFilterClause.h>

#import <ADNKit/ANKEntities.h>
#import <ADNKit/ANKEntity.h>
#import <ADNKit/ANKMentionEntity.h>
#import <ADNKit/ANKHashtagEntity.h>
#import <ADNKit/ANKLinkEntity.h>

#import <ADNKit/ANKTokenStatus.h>
#import <ADNKit/ANKTokenLimits.h>
#import <ADNKit/ANKStorage.h>

#import <ADNKit/ANKObjectSource.h>
#import <ADNKit/ANKInteraction.h>
#import <ADNKit/ANKStreamMarker.h>
#import <ADNKit/ANKExploreStream.h>
#import <ADNKit/ANKAnnotation.h>
#import <ADNKit/ANKImage.h>
#import <ADNKit/ANKGeolocation.h>
#import <ADNKit/ANKOEmbed.h>

#import <ADNKit/ANKValueTransformations.h>
#import <ADNKit/ANKJSONRequestOperation.h>
#import <ADNKit/ANKAPIResponse.h>
#import <ADNKit/ANKAPIResponseMeta.h>
#import <ADNKit/ANKJSONRequestOperation.h>
#import <ADNKit/ANKPaginationSettings.h>
#import <ADNKit/ANKGeneralParameters.h>
#import <ADNKit/ANKSearchQuery.h>

#import <ADNKit/ANKUsernameFormatter.h>

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
#define ANK_IOS 1
#import "ADNKit-iOS.h"
#else
#define ANK_OSX 1
#import "ADNKit-OSX.h"
#endif
