// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsCategoryImpl _$$NewsCategoryImplFromJson(Map<String, dynamic> json) =>
    _$NewsCategoryImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      color: json['color'] as String? ?? '#1565C0',
      icon: json['icon'] as String? ?? 'newspaper_rounded',
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$NewsCategoryImplToJson(_$NewsCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'color': instance.color,
      'icon': instance.icon,
      'sort_order': instance.sortOrder,
      'is_active': instance.isActive,
    };

_$NewsItemImpl _$$NewsItemImplFromJson(Map<String, dynamic> json) =>
    _$NewsItemImpl(
      id: json['id'] as String?,
      categoryId: json['category_id'] as String?,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      slug: json['slug'] as String,
      summary: json['summary'] as String? ?? '',
      content: json['content'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      videoUrl: json['video_url'] as String? ?? '',
      author: json['author'] as String? ?? 'Equipe 45788',
      source: json['source'] as String? ?? '',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      isFeatured: json['is_featured'] as bool? ?? false,
      status: json['status'] as String? ?? 'published',
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
      viewsCount: (json['views_count'] as num?)?.toInt() ?? 0,
      likesCount: (json['likes_count'] as num?)?.toInt() ?? 0,
      commentsCount: (json['comments_count'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      categoryName: json['category_name'] as String?,
      categoryColor: json['category_color'] as String?,
      categoryIcon: json['category_icon'] as String?,
    );

Map<String, dynamic> _$$NewsItemImplToJson(_$NewsItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'slug': instance.slug,
      'summary': instance.summary,
      'content': instance.content,
      'image_url': instance.imageUrl,
      'video_url': instance.videoUrl,
      'author': instance.author,
      'source': instance.source,
      'tags': instance.tags,
      'is_featured': instance.isFeatured,
      'status': instance.status,
      'published_at': instance.publishedAt?.toIso8601String(),
      'views_count': instance.viewsCount,
      'likes_count': instance.likesCount,
      'comments_count': instance.commentsCount,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'category_name': instance.categoryName,
      'category_color': instance.categoryColor,
      'category_icon': instance.categoryIcon,
    };

_$PlanCategoryImpl _$$PlanCategoryImplFromJson(Map<String, dynamic> json) =>
    _$PlanCategoryImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      icon: json['icon'] as String? ?? 'category_rounded',
      color: json['color'] as String? ?? '#1565C0',
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$PlanCategoryImplToJson(_$PlanCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'icon': instance.icon,
      'color': instance.color,
      'sort_order': instance.sortOrder,
      'is_active': instance.isActive,
    };

_$GovernmentPlanImpl _$$GovernmentPlanImplFromJson(Map<String, dynamic> json) =>
    _$GovernmentPlanImpl(
      id: json['id'] as String?,
      categoryId: json['category_id'] as String?,
      title: json['title'] as String,
      slug: json['slug'] as String,
      summary: json['summary'] as String? ?? '',
      description: json['description'] as String? ?? '',
      objectives:
          (json['objectives'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      benefits:
          (json['benefits'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      impact: json['impact'] as String? ?? '',
      status: json['status'] as String? ?? 'planejado',
      progress: (json['progress'] as num?)?.toInt() ?? 0,
      tone: json['tone'] as String? ?? 'primary',
      pdfUrl: json['pdf_url'] as String? ?? '',
      isFeatured: json['is_featured'] as bool? ?? false,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
      categoryName: json['category_name'] as String?,
      categoryIcon: json['category_icon'] as String?,
      categoryColor: json['category_color'] as String?,
    );

Map<String, dynamic> _$$GovernmentPlanImplToJson(
  _$GovernmentPlanImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'category_id': instance.categoryId,
  'title': instance.title,
  'slug': instance.slug,
  'summary': instance.summary,
  'description': instance.description,
  'objectives': instance.objectives,
  'benefits': instance.benefits,
  'impact': instance.impact,
  'status': instance.status,
  'progress': instance.progress,
  'tone': instance.tone,
  'pdf_url': instance.pdfUrl,
  'is_featured': instance.isFeatured,
  'sort_order': instance.sortOrder,
  'is_active': instance.isActive,
  'category_name': instance.categoryName,
  'category_icon': instance.categoryIcon,
  'category_color': instance.categoryColor,
};

_$CityImpl _$$CityImplFromJson(Map<String, dynamic> json) => _$CityImpl(
  id: json['id'] as String?,
  name: json['name'] as String,
  slug: json['slug'] as String,
  state: json['state'] as String? ?? 'BA',
  region: json['region'] as String? ?? '',
  latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
  longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
  population: (json['population'] as num?)?.toInt() ?? 0,
  imageUrl: json['image_url'] as String? ?? '',
  isActive: json['is_active'] as bool? ?? true,
);

Map<String, dynamic> _$$CityImplToJson(_$CityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'state': instance.state,
      'region': instance.region,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'population': instance.population,
      'image_url': instance.imageUrl,
      'is_active': instance.isActive,
    };

_$EventItemImpl _$$EventItemImplFromJson(Map<String, dynamic> json) =>
    _$EventItemImpl(
      id: json['id'] as String?,
      cityId: json['city_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      locationName: json['location_name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      startsAt: DateTime.parse(json['starts_at'] as String),
      endsAt: json['ends_at'] == null
          ? null
          : DateTime.parse(json['ends_at'] as String),
      eventType: json['event_type'] as String? ?? 'outro',
      status: json['status'] as String? ?? 'agendado',
      imageUrl: json['image_url'] as String? ?? '',
      rsvpCount: (json['rsvp_count'] as num?)?.toInt() ?? 0,
      isFeatured: json['is_featured'] as bool? ?? false,
      cityName: json['city_name'] as String?,
      cityRegion: json['city_region'] as String?,
      cityLatitude: (json['city_latitude'] as num?)?.toDouble(),
      cityLongitude: (json['city_longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$EventItemImplToJson(_$EventItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'city_id': instance.cityId,
      'title': instance.title,
      'description': instance.description,
      'location_name': instance.locationName,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'starts_at': instance.startsAt.toIso8601String(),
      'ends_at': instance.endsAt?.toIso8601String(),
      'event_type': instance.eventType,
      'status': instance.status,
      'image_url': instance.imageUrl,
      'rsvp_count': instance.rsvpCount,
      'is_featured': instance.isFeatured,
      'city_name': instance.cityName,
      'city_region': instance.cityRegion,
      'city_latitude': instance.cityLatitude,
      'city_longitude': instance.cityLongitude,
    };

_$GalleryItemImpl _$$GalleryItemImplFromJson(Map<String, dynamic> json) =>
    _$GalleryItemImpl(
      id: json['id'] as String?,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      videoUrl: json['video_url'] as String? ?? '',
      category: json['category'] as String? ?? 'geral',
      album: json['album'] as String? ?? '',
      isVideo: json['is_video'] as bool? ?? false,
      isStory: json['is_story'] as bool? ?? false,
      likesCount: (json['likes_count'] as num?)?.toInt() ?? 0,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$GalleryItemImplToJson(_$GalleryItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'video_url': instance.videoUrl,
      'category': instance.category,
      'album': instance.album,
      'is_video': instance.isVideo,
      'is_story': instance.isStory,
      'likes_count': instance.likesCount,
      'sort_order': instance.sortOrder,
      'is_active': instance.isActive,
    };

_$VideoItemImpl _$$VideoItemImplFromJson(Map<String, dynamic> json) =>
    _$VideoItemImpl(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      youtubeId: json['youtube_id'] as String? ?? '',
      videoUrl: json['video_url'] as String? ?? '',
      thumbnailUrl: json['thumbnail_url'] as String? ?? '',
      videoType: json['video_type'] as String? ?? 'outro',
      category: json['category'] as String? ?? 'geral',
      durationSeconds: (json['duration_seconds'] as num?)?.toInt() ?? 0,
      viewsCount: (json['views_count'] as num?)?.toInt() ?? 0,
      isFeatured: json['is_featured'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$VideoItemImplToJson(_$VideoItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'youtube_id': instance.youtubeId,
      'video_url': instance.videoUrl,
      'thumbnail_url': instance.thumbnailUrl,
      'video_type': instance.videoType,
      'category': instance.category,
      'duration_seconds': instance.durationSeconds,
      'views_count': instance.viewsCount,
      'is_featured': instance.isFeatured,
      'is_active': instance.isActive,
    };

_$VolunteerRequestImpl _$$VolunteerRequestImplFromJson(
  Map<String, dynamic> json,
) => _$VolunteerRequestImpl(
  id: json['id'] as String?,
  fullName: json['full_name'] as String,
  email: json['email'] as String? ?? '',
  phone: json['phone'] as String? ?? '',
  whatsapp: json['whatsapp'] as String? ?? '',
  city: json['city'] as String? ?? '',
  neighborhood: json['neighborhood'] as String? ?? '',
  availability:
      (json['availability'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  areas:
      (json['areas'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  message: json['message'] as String? ?? '',
  status: json['status'] as String? ?? 'pendente',
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$VolunteerRequestImplToJson(
  _$VolunteerRequestImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'full_name': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'whatsapp': instance.whatsapp,
  'city': instance.city,
  'neighborhood': instance.neighborhood,
  'availability': instance.availability,
  'areas': instance.areas,
  'message': instance.message,
  'status': instance.status,
  'created_at': instance.createdAt?.toIso8601String(),
};

_$MessageItemImpl _$$MessageItemImplFromJson(Map<String, dynamic> json) =>
    _$MessageItemImpl(
      id: json['id'] as String?,
      deviceId: json['device_id'] as String? ?? '',
      conversationId: json['conversation_id'] as String? ?? '',
      senderName: json['sender_name'] as String? ?? '',
      senderEmail: json['sender_email'] as String? ?? '',
      subject: json['subject'] as String? ?? '',
      category: json['category'] as String? ?? '',
      message: json['message'] as String,
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      channel: json['channel'] as String? ?? 'form',
      parentId: json['parent_id'] as String?,
      isAdminReply: json['is_admin_reply'] as bool? ?? false,
      status: json['status'] as String? ?? 'novo',
      isRead: json['is_read'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$MessageItemImplToJson(_$MessageItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'device_id': instance.deviceId,
      'conversation_id': instance.conversationId,
      'sender_name': instance.senderName,
      'sender_email': instance.senderEmail,
      'subject': instance.subject,
      'category': instance.category,
      'message': instance.message,
      'attachments': instance.attachments,
      'channel': instance.channel,
      'parent_id': instance.parentId,
      'is_admin_reply': instance.isAdminReply,
      'status': instance.status,
      'is_read': instance.isRead,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$ReportItemImpl _$$ReportItemImplFromJson(Map<String, dynamic> json) =>
    _$ReportItemImpl(
      id: json['id'] as String?,
      deviceId: json['device_id'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      city: json['city'] as String? ?? '',
      category: json['category'] as String? ?? 'outro',
      description: json['description'] as String,
      imageUrl: json['image_url'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      status: json['status'] as String? ?? 'pendente',
      adminNote: json['admin_note'] as String? ?? '',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ReportItemImplToJson(_$ReportItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'device_id': instance.deviceId,
      'full_name': instance.fullName,
      'city': instance.city,
      'category': instance.category,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'status': instance.status,
      'admin_note': instance.adminNote,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$DownloadItemImpl _$$DownloadItemImplFromJson(Map<String, dynamic> json) =>
    _$DownloadItemImpl(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      fileUrl: json['file_url'] as String? ?? '',
      fileType: json['file_type'] as String? ?? 'pdf',
      fileSize: (json['file_size'] as num?)?.toInt() ?? 0,
      icon: json['icon'] as String? ?? 'download_rounded',
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$DownloadItemImplToJson(_$DownloadItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'file_url': instance.fileUrl,
      'file_type': instance.fileType,
      'file_size': instance.fileSize,
      'icon': instance.icon,
      'sort_order': instance.sortOrder,
      'is_active': instance.isActive,
    };

_$SocialLinkImpl _$$SocialLinkImplFromJson(Map<String, dynamic> json) =>
    _$SocialLinkImpl(
      id: json['id'] as String?,
      platform: json['platform'] as String,
      url: json['url'] as String,
      username: json['username'] as String? ?? '',
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$SocialLinkImplToJson(_$SocialLinkImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'platform': instance.platform,
      'url': instance.url,
      'username': instance.username,
      'sort_order': instance.sortOrder,
      'is_active': instance.isActive,
    };

_$CampaignNumberImpl _$$CampaignNumberImplFromJson(Map<String, dynamic> json) =>
    _$CampaignNumberImpl(
      id: json['id'] as String?,
      label: json['label'] as String,
      value: json['value'] as String,
      trend: json['trend'] as String? ?? '',
      isPositive: json['is_positive'] as bool? ?? true,
      tone: json['tone'] as String? ?? 'primary',
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$CampaignNumberImplToJson(
  _$CampaignNumberImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'value': instance.value,
  'trend': instance.trend,
  'is_positive': instance.isPositive,
  'tone': instance.tone,
  'sort_order': instance.sortOrder,
  'is_active': instance.isActive,
};

_$BannerHomeImpl _$$BannerHomeImplFromJson(Map<String, dynamic> json) =>
    _$BannerHomeImpl(
      id: json['id'] as String?,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      badge: json['badge'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      ctaLabel: json['cta_label'] as String? ?? '',
      ctaUrl: json['cta_url'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$BannerHomeImplToJson(_$BannerHomeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'badge': instance.badge,
      'image_url': instance.imageUrl,
      'cta_label': instance.ctaLabel,
      'cta_url': instance.ctaUrl,
      'is_active': instance.isActive,
      'sort_order': instance.sortOrder,
    };

_$TeamMemberImpl _$$TeamMemberImplFromJson(Map<String, dynamic> json) =>
    _$TeamMemberImpl(
      id: json['id'] as String?,
      fullName: json['full_name'] as String,
      role: json['role'] as String? ?? '',
      photoUrl: json['photo_url'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$TeamMemberImplToJson(_$TeamMemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'role': instance.role,
      'photo_url': instance.photoUrl,
      'bio': instance.bio,
      'sort_order': instance.sortOrder,
      'is_active': instance.isActive,
    };

_$TestimonialImpl _$$TestimonialImplFromJson(Map<String, dynamic> json) =>
    _$TestimonialImpl(
      id: json['id'] as String?,
      authorName: json['author_name'] as String,
      city: json['city'] as String? ?? '',
      role: json['role'] as String? ?? '',
      content: json['content'] as String,
      photoUrl: json['photo_url'] as String? ?? '',
      rating: (json['rating'] as num?)?.toInt() ?? 5,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$TestimonialImplToJson(_$TestimonialImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author_name': instance.authorName,
      'city': instance.city,
      'role': instance.role,
      'content': instance.content,
      'photo_url': instance.photoUrl,
      'rating': instance.rating,
      'sort_order': instance.sortOrder,
      'is_active': instance.isActive,
    };

_$FaqItemImpl _$$FaqItemImplFromJson(Map<String, dynamic> json) =>
    _$FaqItemImpl(
      id: json['id'] as String?,
      question: json['question'] as String,
      answer: json['answer'] as String,
      category: json['category'] as String? ?? 'geral',
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$FaqItemImplToJson(_$FaqItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
      'category': instance.category,
      'sort_order': instance.sortOrder,
      'is_active': instance.isActive,
    };

_$CommentItemImpl _$$CommentItemImplFromJson(Map<String, dynamic> json) =>
    _$CommentItemImpl(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      fullName: json['full_name'] as String? ?? '',
      targetType: json['target_type'] as String,
      targetId: json['target_id'] as String,
      content: json['content'] as String,
      parentId: json['parent_id'] as String?,
      isApproved: json['is_approved'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      authorName: json['author_name'] as String?,
      authorAvatar: json['author_avatar'] as String?,
    );

Map<String, dynamic> _$$CommentItemImplToJson(_$CommentItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'target_type': instance.targetType,
      'target_id': instance.targetId,
      'content': instance.content,
      'parent_id': instance.parentId,
      'is_approved': instance.isApproved,
      'created_at': instance.createdAt?.toIso8601String(),
      'author_name': instance.authorName,
      'author_avatar': instance.authorAvatar,
    };

_$NotificationItemImpl _$$NotificationItemImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationItemImpl(
  id: json['id'] as String?,
  userId: json['user_id'] as String?,
  title: json['title'] as String,
  body: json['body'] as String? ?? '',
  data: json['data'] as Map<String, dynamic>? ?? const {},
  channel: json['channel'] as String? ?? 'in_app',
  city: json['city'] as String? ?? '',
  isRead: json['is_read'] as bool? ?? false,
  isActive: json['is_active'] as bool? ?? true,
  sentAt: json['sent_at'] == null
      ? null
      : DateTime.parse(json['sent_at'] as String),
);

Map<String, dynamic> _$$NotificationItemImplToJson(
  _$NotificationItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'title': instance.title,
  'body': instance.body,
  'data': instance.data,
  'channel': instance.channel,
  'city': instance.city,
  'is_read': instance.isRead,
  'is_active': instance.isActive,
  'sent_at': instance.sentAt?.toIso8601String(),
};

_$SearchResultImpl _$$SearchResultImplFromJson(Map<String, dynamic> json) =>
    _$SearchResultImpl(
      resultType: json['result_type'] as String,
      id: json['id'] as String?,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      category: json['category'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      urlPath: json['url_path'] as String? ?? '',
    );

Map<String, dynamic> _$$SearchResultImplToJson(_$SearchResultImpl instance) =>
    <String, dynamic>{
      'result_type': instance.resultType,
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'category': instance.category,
      'image_url': instance.imageUrl,
      'slug': instance.slug,
      'url_path': instance.urlPath,
    };

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      id: json['id'] as String?,
      fullName: json['full_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      city: json['city'] as String? ?? '',
      role: json['role'] as String? ?? 'user',
      avatarUrl: json['avatar_url'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'city': instance.city,
      'role': instance.role,
      'avatar_url': instance.avatarUrl,
      'bio': instance.bio,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$DashboardCountsImpl _$$DashboardCountsImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardCountsImpl(
  newsCount: (json['news_count'] as num?)?.toInt() ?? 0,
  planCount: (json['plan_count'] as num?)?.toInt() ?? 0,
  eventsCount: (json['events_count'] as num?)?.toInt() ?? 0,
  citiesCount: (json['cities_count'] as num?)?.toInt() ?? 0,
  videosCount: (json['videos_count'] as num?)?.toInt() ?? 0,
  galleryCount: (json['gallery_count'] as num?)?.toInt() ?? 0,
  volunteersPending: (json['volunteers_pending'] as num?)?.toInt() ?? 0,
  messagesNew: (json['messages_new'] as num?)?.toInt() ?? 0,
  reportsPending: (json['reports_pending'] as num?)?.toInt() ?? 0,
  likesCount: (json['likes_count'] as num?)?.toInt() ?? 0,
  commentsCount: (json['comments_count'] as num?)?.toInt() ?? 0,
  profilesCount: (json['profiles_count'] as num?)?.toInt() ?? 0,
  auditCount: (json['audit_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$DashboardCountsImplToJson(
  _$DashboardCountsImpl instance,
) => <String, dynamic>{
  'news_count': instance.newsCount,
  'plan_count': instance.planCount,
  'events_count': instance.eventsCount,
  'cities_count': instance.citiesCount,
  'videos_count': instance.videosCount,
  'gallery_count': instance.galleryCount,
  'volunteers_pending': instance.volunteersPending,
  'messages_new': instance.messagesNew,
  'reports_pending': instance.reportsPending,
  'likes_count': instance.likesCount,
  'comments_count': instance.commentsCount,
  'profiles_count': instance.profilesCount,
  'audit_count': instance.auditCount,
};

_$BiographyItemImpl _$$BiographyItemImplFromJson(Map<String, dynamic> json) =>
    _$BiographyItemImpl(
      id: json['id'] as String?,
      itemType: json['item_type'] as String? ?? 'historia',
      year: json['year'] as String? ?? '',
      title: json['title'] as String,
      text: json['text'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$BiographyItemImplToJson(_$BiographyItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item_type': instance.itemType,
      'year': instance.year,
      'title': instance.title,
      'text': instance.text,
      'image_url': instance.imageUrl,
      'sort_order': instance.sortOrder,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
    };
