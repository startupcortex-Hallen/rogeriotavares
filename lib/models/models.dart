// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
abstract class NewsCategory with _$NewsCategory {
  const factory NewsCategory({
    String? id,
    String? name,
    String? slug,
    @JsonKey(name: 'color') @Default('#1565C0') String color,
    @JsonKey(name: 'icon') @Default('newspaper_rounded') String icon,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _NewsCategory;

  factory NewsCategory.fromJson(Map<String, dynamic> json) =>
      _$NewsCategoryFromJson(json);
}

@freezed
abstract class NewsItem with _$NewsItem {
  const factory NewsItem({
    String? id,
    @JsonKey(name: 'category_id') String? categoryId,
    required String title,
    @Default('') String subtitle,
    required String slug,
    @Default('') String summary,
    @Default('') String content,
    @JsonKey(name: 'image_url') @Default('') String imageUrl,
    @JsonKey(name: 'video_url') @Default('') String videoUrl,
    @Default('Equipe 45788') String author,
    @Default('') String source,
    @Default([]) List<String> tags,
    @JsonKey(name: 'is_featured') @Default(false) bool isFeatured,
    @Default('published') String status,
    @JsonKey(name: 'published_at') DateTime? publishedAt,
    @JsonKey(name: 'views_count') @Default(0) int viewsCount,
    @JsonKey(name: 'likes_count') @Default(0) int likesCount,
    @JsonKey(name: 'comments_count') @Default(0) int commentsCount,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_color') String? categoryColor,
    @JsonKey(name: 'category_icon') String? categoryIcon,
  }) = _NewsItem;

  const NewsItem._();

  factory NewsItem.fromJson(Map<String, dynamic> json) =>
      _$NewsItemFromJson(json);

  bool get isVideo =>
      videoUrl.isNotEmpty || (categoryName ?? '').toUpperCase() == 'VÍDEOS';
}

@freezed
abstract class PlanCategory with _$PlanCategory {
  const factory PlanCategory({
    String? id,
    String? name,
    String? slug,
    @JsonKey(name: 'icon') @Default('category_rounded') String icon,
    @JsonKey(name: 'color') @Default('#1565C0') String color,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _PlanCategory;

  factory PlanCategory.fromJson(Map<String, dynamic> json) =>
      _$PlanCategoryFromJson(json);
}

@freezed
abstract class GovernmentPlan with _$GovernmentPlan {
  const factory GovernmentPlan({
    String? id,
    @JsonKey(name: 'category_id') String? categoryId,
    required String title,
    required String slug,
    @Default('') String summary,
    @Default('') String description,
    @Default([]) List<String> objectives,
    @Default([]) List<String> benefits,
    @Default('') String impact,
    @Default('planejado') String status,
    @Default(0) int progress,
    @Default('primary') String tone,
    @JsonKey(name: 'pdf_url') @Default('') String pdfUrl,
    @JsonKey(name: 'is_featured') @Default(false) bool isFeatured,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_icon') String? categoryIcon,
    @JsonKey(name: 'category_color') String? categoryColor,
  }) = _GovernmentPlan;

  const GovernmentPlan._();

  factory GovernmentPlan.fromJson(Map<String, dynamic> json) =>
      _$GovernmentPlanFromJson(json);

  static const statusLabels = {
    'planejado': 'Planejado',
    'em_andamento': 'Em andamento',
    'concluido': 'Concluído',
  };

  String get statusLabel => statusLabels[status] ?? status;
}

@freezed
abstract class City with _$City {
  const factory City({
    String? id,
    required String name,
    required String slug,
    @JsonKey(name: 'state') @Default('BA') String state,
    @Default('') String region,
    @Default(0) double latitude,
    @Default(0) double longitude,
    @Default(0) int population,
    @JsonKey(name: 'image_url') @Default('') String imageUrl,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}

@freezed
abstract class EventItem with _$EventItem {
  const factory EventItem({
    String? id,
    @JsonKey(name: 'city_id') String? cityId,
    required String title,
    @Default('') String description,
    @JsonKey(name: 'location_name') @Default('') String locationName,
    @Default('') String address,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'starts_at') required DateTime startsAt,
    @JsonKey(name: 'ends_at') DateTime? endsAt,
    @JsonKey(name: 'event_type') @Default('outro') String eventType,
    @Default('agendado') String status,
    @JsonKey(name: 'image_url') @Default('') String imageUrl,
    @JsonKey(name: 'rsvp_count') @Default(0) int rsvpCount,
    @JsonKey(name: 'is_featured') @Default(false) bool isFeatured,
    @JsonKey(name: 'city_name') String? cityName,
    @JsonKey(name: 'city_region') String? cityRegion,
    @JsonKey(name: 'city_latitude') double? cityLatitude,
    @JsonKey(name: 'city_longitude') double? cityLongitude,
  }) = _EventItem;

  const EventItem._();

  factory EventItem.fromJson(Map<String, dynamic> json) =>
      _$EventItemFromJson(json);

  static const typeLabels = {
    'reuniao': 'Reunião',
    'caminhada': 'Caminhada',
    'live': 'Live',
    'caravana': 'Caravana',
    'plenaria': 'Plenária',
    'entrevista': 'Entrevista',
    'programa': 'Programa Eleitoral',
    'debate': 'Debate',
    'visita': 'Visita',
    'outro': 'Evento',
  };

  String get typeLabel => typeLabels[eventType] ?? 'Evento';
}

@freezed
abstract class GalleryItem with _$GalleryItem {
  const factory GalleryItem({
    String? id,
    @Default('') String title,
    @Default('') String description,
    @JsonKey(name: 'image_url') @Default('') String imageUrl,
    @JsonKey(name: 'video_url') @Default('') String videoUrl,
    @Default('geral') String category,
    @Default('') String album,
    @JsonKey(name: 'is_video') @Default(false) bool isVideo,
    @JsonKey(name: 'is_story') @Default(false) bool isStory,
    @JsonKey(name: 'likes_count') @Default(0) int likesCount,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _GalleryItem;

  factory GalleryItem.fromJson(Map<String, dynamic> json) =>
      _$GalleryItemFromJson(json);
}

@freezed
abstract class VideoItem with _$VideoItem {
  const factory VideoItem({
    String? id,
    required String title,
    @Default('') String description,
    @JsonKey(name: 'youtube_id') @Default('') String youtubeId,
    @JsonKey(name: 'video_url') @Default('') String videoUrl,
    @JsonKey(name: 'thumbnail_url') @Default('') String thumbnailUrl,
    @JsonKey(name: 'video_type') @Default('outro') String videoType,
    @Default('geral') String category,
    @JsonKey(name: 'duration_seconds') @Default(0) int durationSeconds,
    @JsonKey(name: 'views_count') @Default(0) int viewsCount,
    @JsonKey(name: 'is_featured') @Default(false) bool isFeatured,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _VideoItem;

  factory VideoItem.fromJson(Map<String, dynamic> json) =>
      _$VideoItemFromJson(json);
}

@freezed
abstract class VolunteerRequest with _$VolunteerRequest {
  const factory VolunteerRequest({
    String? id,
    @JsonKey(name: 'full_name') required String fullName,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String whatsapp,
    @Default('') String city,
    @Default('') String neighborhood,
    @Default([]) List<String> availability,
    @Default([]) List<String> areas,
    @Default('') String message,
    @Default('pendente') String status,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _VolunteerRequest;

  factory VolunteerRequest.fromJson(Map<String, dynamic> json) =>
      _$VolunteerRequestFromJson(json);
}

@freezed
abstract class MessageItem with _$MessageItem {
  const factory MessageItem({
    String? id,
    @JsonKey(name: 'device_id') @Default('') String deviceId,
    @JsonKey(name: 'conversation_id') @Default('') String conversationId,
    @JsonKey(name: 'sender_name') @Default('') String senderName,
    @JsonKey(name: 'sender_email') @Default('') String senderEmail,
    @Default('') String subject,
    @Default('') String category,
    required String message,
    @Default([]) List<String> attachments,
    @Default('form') String channel,
    @JsonKey(name: 'parent_id') String? parentId,
    @JsonKey(name: 'is_admin_reply') @Default(false) bool isAdminReply,
    @Default('novo') String status,
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _MessageItem;

  factory MessageItem.fromJson(Map<String, dynamic> json) =>
      _$MessageItemFromJson(json);
}

@freezed
abstract class ReportItem with _$ReportItem {
  const factory ReportItem({
    String? id,
    @JsonKey(name: 'device_id') @Default('') String deviceId,
    @JsonKey(name: 'full_name') @Default('') String fullName,
    @Default('') String city,
    @Default('outro') String category,
    required String description,
    @JsonKey(name: 'image_url') @Default('') String imageUrl,
    double? latitude,
    double? longitude,
    @Default('pendente') String status,
    @JsonKey(name: 'admin_note') @Default('') String adminNote,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ReportItem;

  const ReportItem._();

  factory ReportItem.fromJson(Map<String, dynamic> json) =>
      _$ReportItemFromJson(json);

  static const statusLabels = {
    'pendente': 'Pendente',
    'aprovado': 'Aprovado',
    'recusado': 'Recusado',
    'em_andamento': 'Em andamento',
    'concluido': 'Concluído',
  };

  String get statusLabel => statusLabels[status] ?? status;
}

@freezed
abstract class DownloadItem with _$DownloadItem {
  const factory DownloadItem({
    String? id,
    required String title,
    @Default('') String description,
    @JsonKey(name: 'file_url') @Default('') String fileUrl,
    @JsonKey(name: 'file_type') @Default('pdf') String fileType,
    @JsonKey(name: 'file_size') @Default(0) int fileSize,
    @Default('download_rounded') String icon,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _DownloadItem;

  factory DownloadItem.fromJson(Map<String, dynamic> json) =>
      _$DownloadItemFromJson(json);
}

@freezed
abstract class SocialLink with _$SocialLink {
  const factory SocialLink({
    String? id,
    required String platform,
    required String url,
    @Default('') String username,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _SocialLink;

  factory SocialLink.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkFromJson(json);
}

@freezed
abstract class CampaignNumber with _$CampaignNumber {
  const factory CampaignNumber({
    String? id,
    required String label,
    required String value,
    @Default('') String trend,
    @JsonKey(name: 'is_positive') @Default(true) bool isPositive,
    @Default('primary') String tone,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _CampaignNumber;

  factory CampaignNumber.fromJson(Map<String, dynamic> json) =>
      _$CampaignNumberFromJson(json);
}

@freezed
abstract class BannerHome with _$BannerHome {
  const factory BannerHome({
    String? id,
    required String title,
    @Default('') String subtitle,
    @Default('') String badge,
    @JsonKey(name: 'image_url') @Default('') String imageUrl,
    @JsonKey(name: 'cta_label') @Default('') String ctaLabel,
    @JsonKey(name: 'cta_url') @Default('') String ctaUrl,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
  }) = _BannerHome;

  factory BannerHome.fromJson(Map<String, dynamic> json) =>
      _$BannerHomeFromJson(json);
}

@freezed
abstract class TeamMember with _$TeamMember {
  const factory TeamMember({
    String? id,
    @JsonKey(name: 'full_name') required String fullName,
    @Default('') String role,
    @JsonKey(name: 'photo_url') @Default('') String photoUrl,
    @Default('') String bio,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _TeamMember;

  factory TeamMember.fromJson(Map<String, dynamic> json) =>
      _$TeamMemberFromJson(json);
}

@freezed
abstract class Testimonial with _$Testimonial {
  const factory Testimonial({
    String? id,
    @JsonKey(name: 'author_name') required String authorName,
    @Default('') String city,
    @Default('') String role,
    required String content,
    @JsonKey(name: 'photo_url') @Default('') String photoUrl,
    @Default(5) int rating,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _Testimonial;

  factory Testimonial.fromJson(Map<String, dynamic> json) =>
      _$TestimonialFromJson(json);
}

@freezed
abstract class FaqItem with _$FaqItem {
  const factory FaqItem({
    String? id,
    required String question,
    required String answer,
    @Default('geral') String category,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _FaqItem;

  factory FaqItem.fromJson(Map<String, dynamic> json) => _$FaqItemFromJson(json);
}

@freezed
abstract class CommentItem with _$CommentItem {
  const factory CommentItem({
    String? id,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'full_name') @Default('') String fullName,
    @JsonKey(name: 'target_type') required String targetType,
    @JsonKey(name: 'target_id') required String targetId,
    required String content,
    @JsonKey(name: 'parent_id') String? parentId,
    @JsonKey(name: 'is_approved') @Default(true) bool isApproved,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'author_name') String? authorName,
    @JsonKey(name: 'author_avatar') String? authorAvatar,
  }) = _CommentItem;

  factory CommentItem.fromJson(Map<String, dynamic> json) =>
      _$CommentItemFromJson(json);
}

@freezed
abstract class NotificationItem with _$NotificationItem {
  const factory NotificationItem({
    String? id,
    @JsonKey(name: 'user_id') String? userId,
    required String title,
    @Default('') String body,
    @Default({}) Map<String, dynamic> data,
    @Default('in_app') String channel,
    @Default('') String city,
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'sent_at') DateTime? sentAt,
  }) = _NotificationItem;

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);
}

@freezed
abstract class SearchResult with _$SearchResult {
  const factory SearchResult({
    @JsonKey(name: 'result_type') required String resultType,
    String? id,
    required String title,
    @Default('') String subtitle,
    @Default('') String category,
    @JsonKey(name: 'image_url') @Default('') String imageUrl,
    @Default('') String slug,
    @JsonKey(name: 'url_path') @Default('') String urlPath,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    String? id,
    @JsonKey(name: 'full_name') @Default('') String fullName,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String city,
    @Default('user') String role,
    @JsonKey(name: 'avatar_url') @Default('') String avatarUrl,
    @Default('') String bio,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Profile;

  const Profile._();

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  bool get isAdmin => role == 'admin';
  bool get isModerator => role == 'moderator' || isAdmin;
  bool get isEditor => role == 'editor' || isModerator;
}

@freezed
abstract class DashboardCounts with _$DashboardCounts {
  const factory DashboardCounts({
    @JsonKey(name: 'news_count') @Default(0) int newsCount,
    @JsonKey(name: 'plan_count') @Default(0) int planCount,
    @JsonKey(name: 'events_count') @Default(0) int eventsCount,
    @JsonKey(name: 'cities_count') @Default(0) int citiesCount,
    @JsonKey(name: 'videos_count') @Default(0) int videosCount,
    @JsonKey(name: 'gallery_count') @Default(0) int galleryCount,
    @JsonKey(name: 'volunteers_pending') @Default(0) int volunteersPending,
    @JsonKey(name: 'messages_new') @Default(0) int messagesNew,
    @JsonKey(name: 'reports_pending') @Default(0) int reportsPending,
    @JsonKey(name: 'likes_count') @Default(0) int likesCount,
    @JsonKey(name: 'comments_count') @Default(0) int commentsCount,
    @JsonKey(name: 'profiles_count') @Default(0) int profilesCount,
    @JsonKey(name: 'audit_count') @Default(0) int auditCount,
  }) = _DashboardCounts;

  factory DashboardCounts.fromJson(Map<String, dynamic> json) =>
      _$DashboardCountsFromJson(json);
}

@freezed
abstract class BiographyItem with _$BiographyItem {
  const factory BiographyItem({
    String? id,
    @JsonKey(name: 'item_type') @Default('historia') String itemType,
    @Default('') String year,
    required String title,
    @Default('') String text,
    @Default('') @JsonKey(name: 'image_url') String imageUrl,
    @Default(0) @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _BiographyItem;

  factory BiographyItem.fromJson(Map<String, dynamic> json) =>
      _$BiographyItemFromJson(json);
}