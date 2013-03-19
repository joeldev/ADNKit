/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "AFNetworking.h"

#import "ANKClient.h"
#import "ANKClient+ANKUser.h"
#import "ANKClient+ANKPost.h"
#import "ANKClient+ANKPostStreams.h"
#import "ANKClient+ANKFile.h"
#import "ANKClient+ANKPlace.h"
#import "ANKClient+ANKChannel.h"
#import "ANKClient+ANKMessage.h"
#import "ANKClient+ANKStream.h"
#import "ANKClient+ANKInteraction.h"
#import "ANKClient+ANKExploreStream.h"
#import "ANKClient+ANKFilter.h"
#import "ANKClient+ANKTokenStatus.h"

#import "ANKResource.h"
#import "ANKAnnotatableResource.h"
#import "ANKAnnotationReplacement.h"

#import "ANKUser.h"
#import "ANKUserCounts.h"
#import "ANKUserDescription.h"

#import "ANKChannel.h"
#import "ANKChannelCounts.h"
#import "ANKACL.h"

#import "ANKPlace.h"
#import "ANKPlaceCategory.h"

#import "ANKPost.h"
#import "ANKMessage.h"
#import "ANKFile.h"
#import "ANKStream.h"
#import "ANKFilter.h"
#import "ANKFilterClause.h"

#import "ANKEntities.h"
#import "ANKEntity.h"
#import "ANKMentionEntity.h"
#import "ANKHashtagEntity.h"
#import "ANKLinkEntity.h"

#import "ANKTokenStatus.h"
#import "ANKStorage.h"

#import "ANKObjectSource.h"
#import "ANKInteraction.h"
#import "ANKStreamMarker.h"
#import "ANKExploreStream.h"
#import "ANKAnnotation.h"
#import "ANKImage.h"
#import "ANKGeolocation.h"
#import "ANKOEmbed.h"

#import "ANKValueTransformations.h"
#import "ANKJSONRequestOperation.h"
#import "ANKAPIResponse.h"
#import "ANKAPIResponseMeta.h"
#import "ANKPaginationSettings.h"

#import "ANKUsernameFormatter.h"

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
#import "ADNKit-iOS.h"
#else
#import "ADNKit-OSX.h"
#endif
