// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NewsCategory _$NewsCategoryFromJson(Map<String, dynamic> json) {
  return _NewsCategory.fromJson(json);
}

/// @nodoc
mixin _$NewsCategory {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'color')
  String get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'icon')
  String get icon => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this NewsCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewsCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewsCategoryCopyWith<NewsCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsCategoryCopyWith<$Res> {
  factory $NewsCategoryCopyWith(
    NewsCategory value,
    $Res Function(NewsCategory) then,
  ) = _$NewsCategoryCopyWithImpl<$Res, NewsCategory>;
  @useResult
  $Res call({
    String? id,
    String? name,
    String? slug,
    @JsonKey(name: 'color') String color,
    @JsonKey(name: 'icon') String icon,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$NewsCategoryCopyWithImpl<$Res, $Val extends NewsCategory>
    implements $NewsCategoryCopyWith<$Res> {
  _$NewsCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewsCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
    Object? color = null,
    Object? icon = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            slug: freezed == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String?,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NewsCategoryImplCopyWith<$Res>
    implements $NewsCategoryCopyWith<$Res> {
  factory _$$NewsCategoryImplCopyWith(
    _$NewsCategoryImpl value,
    $Res Function(_$NewsCategoryImpl) then,
  ) = __$$NewsCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? name,
    String? slug,
    @JsonKey(name: 'color') String color,
    @JsonKey(name: 'icon') String icon,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$NewsCategoryImplCopyWithImpl<$Res>
    extends _$NewsCategoryCopyWithImpl<$Res, _$NewsCategoryImpl>
    implements _$$NewsCategoryImplCopyWith<$Res> {
  __$$NewsCategoryImplCopyWithImpl(
    _$NewsCategoryImpl _value,
    $Res Function(_$NewsCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
    Object? color = null,
    Object? icon = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _$NewsCategoryImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        slug: freezed == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String?,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsCategoryImpl implements _NewsCategory {
  const _$NewsCategoryImpl({
    this.id,
    this.name,
    this.slug,
    @JsonKey(name: 'color') this.color = '#1565C0',
    @JsonKey(name: 'icon') this.icon = 'newspaper_rounded',
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$NewsCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsCategoryImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? slug;
  @override
  @JsonKey(name: 'color')
  final String color;
  @override
  @JsonKey(name: 'icon')
  final String icon;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'NewsCategory(id: $id, name: $name, slug: $slug, color: $color, icon: $icon, sortOrder: $sortOrder, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    slug,
    color,
    icon,
    sortOrder,
    isActive,
  );

  /// Create a copy of NewsCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsCategoryImplCopyWith<_$NewsCategoryImpl> get copyWith =>
      __$$NewsCategoryImplCopyWithImpl<_$NewsCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsCategoryImplToJson(this);
  }
}

abstract class _NewsCategory implements NewsCategory {
  const factory _NewsCategory({
    final String? id,
    final String? name,
    final String? slug,
    @JsonKey(name: 'color') final String color,
    @JsonKey(name: 'icon') final String icon,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$NewsCategoryImpl;

  factory _NewsCategory.fromJson(Map<String, dynamic> json) =
      _$NewsCategoryImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get slug;
  @override
  @JsonKey(name: 'color')
  String get color;
  @override
  @JsonKey(name: 'icon')
  String get icon;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of NewsCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsCategoryImplCopyWith<_$NewsCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NewsItem _$NewsItemFromJson(Map<String, dynamic> json) {
  return _NewsItem.fromJson(json);
}

/// @nodoc
mixin _$NewsItem {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String? get categoryId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'video_url')
  String get videoUrl => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_featured')
  bool get isFeatured => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'published_at')
  DateTime? get publishedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'views_count')
  int get viewsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'likes_count')
  int get likesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'comments_count')
  int get commentsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_color')
  String? get categoryColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_icon')
  String? get categoryIcon => throw _privateConstructorUsedError;

  /// Serializes this NewsItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewsItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewsItemCopyWith<NewsItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsItemCopyWith<$Res> {
  factory $NewsItemCopyWith(NewsItem value, $Res Function(NewsItem) then) =
      _$NewsItemCopyWithImpl<$Res, NewsItem>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'category_id') String? categoryId,
    String title,
    String subtitle,
    String slug,
    String summary,
    String content,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'video_url') String videoUrl,
    String author,
    String source,
    List<String> tags,
    @JsonKey(name: 'is_featured') bool isFeatured,
    String status,
    @JsonKey(name: 'published_at') DateTime? publishedAt,
    @JsonKey(name: 'views_count') int viewsCount,
    @JsonKey(name: 'likes_count') int likesCount,
    @JsonKey(name: 'comments_count') int commentsCount,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_color') String? categoryColor,
    @JsonKey(name: 'category_icon') String? categoryIcon,
  });
}

/// @nodoc
class _$NewsItemCopyWithImpl<$Res, $Val extends NewsItem>
    implements $NewsItemCopyWith<$Res> {
  _$NewsItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewsItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? categoryId = freezed,
    Object? title = null,
    Object? subtitle = null,
    Object? slug = null,
    Object? summary = null,
    Object? content = null,
    Object? imageUrl = null,
    Object? videoUrl = null,
    Object? author = null,
    Object? source = null,
    Object? tags = null,
    Object? isFeatured = null,
    Object? status = null,
    Object? publishedAt = freezed,
    Object? viewsCount = null,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? categoryName = freezed,
    Object? categoryColor = freezed,
    Object? categoryIcon = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            videoUrl: null == videoUrl
                ? _value.videoUrl
                : videoUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            author: null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as String,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            publishedAt: freezed == publishedAt
                ? _value.publishedAt
                : publishedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            viewsCount: null == viewsCount
                ? _value.viewsCount
                : viewsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            likesCount: null == likesCount
                ? _value.likesCount
                : likesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            commentsCount: null == commentsCount
                ? _value.commentsCount
                : commentsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryColor: freezed == categoryColor
                ? _value.categoryColor
                : categoryColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryIcon: freezed == categoryIcon
                ? _value.categoryIcon
                : categoryIcon // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NewsItemImplCopyWith<$Res>
    implements $NewsItemCopyWith<$Res> {
  factory _$$NewsItemImplCopyWith(
    _$NewsItemImpl value,
    $Res Function(_$NewsItemImpl) then,
  ) = __$$NewsItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'category_id') String? categoryId,
    String title,
    String subtitle,
    String slug,
    String summary,
    String content,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'video_url') String videoUrl,
    String author,
    String source,
    List<String> tags,
    @JsonKey(name: 'is_featured') bool isFeatured,
    String status,
    @JsonKey(name: 'published_at') DateTime? publishedAt,
    @JsonKey(name: 'views_count') int viewsCount,
    @JsonKey(name: 'likes_count') int likesCount,
    @JsonKey(name: 'comments_count') int commentsCount,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_color') String? categoryColor,
    @JsonKey(name: 'category_icon') String? categoryIcon,
  });
}

/// @nodoc
class __$$NewsItemImplCopyWithImpl<$Res>
    extends _$NewsItemCopyWithImpl<$Res, _$NewsItemImpl>
    implements _$$NewsItemImplCopyWith<$Res> {
  __$$NewsItemImplCopyWithImpl(
    _$NewsItemImpl _value,
    $Res Function(_$NewsItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? categoryId = freezed,
    Object? title = null,
    Object? subtitle = null,
    Object? slug = null,
    Object? summary = null,
    Object? content = null,
    Object? imageUrl = null,
    Object? videoUrl = null,
    Object? author = null,
    Object? source = null,
    Object? tags = null,
    Object? isFeatured = null,
    Object? status = null,
    Object? publishedAt = freezed,
    Object? viewsCount = null,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? categoryName = freezed,
    Object? categoryColor = freezed,
    Object? categoryIcon = freezed,
  }) {
    return _then(
      _$NewsItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        videoUrl: null == videoUrl
            ? _value.videoUrl
            : videoUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        author: null == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as String,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        publishedAt: freezed == publishedAt
            ? _value.publishedAt
            : publishedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        viewsCount: null == viewsCount
            ? _value.viewsCount
            : viewsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        likesCount: null == likesCount
            ? _value.likesCount
            : likesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        commentsCount: null == commentsCount
            ? _value.commentsCount
            : commentsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryColor: freezed == categoryColor
            ? _value.categoryColor
            : categoryColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryIcon: freezed == categoryIcon
            ? _value.categoryIcon
            : categoryIcon // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsItemImpl extends _NewsItem {
  const _$NewsItemImpl({
    this.id,
    @JsonKey(name: 'category_id') this.categoryId,
    required this.title,
    this.subtitle = '',
    required this.slug,
    this.summary = '',
    this.content = '',
    @JsonKey(name: 'image_url') this.imageUrl = '',
    @JsonKey(name: 'video_url') this.videoUrl = '',
    this.author = 'Equipe 45788',
    this.source = '',
    final List<String> tags = const [],
    @JsonKey(name: 'is_featured') this.isFeatured = false,
    this.status = 'published',
    @JsonKey(name: 'published_at') this.publishedAt,
    @JsonKey(name: 'views_count') this.viewsCount = 0,
    @JsonKey(name: 'likes_count') this.likesCount = 0,
    @JsonKey(name: 'comments_count') this.commentsCount = 0,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
    @JsonKey(name: 'category_name') this.categoryName,
    @JsonKey(name: 'category_color') this.categoryColor,
    @JsonKey(name: 'category_icon') this.categoryIcon,
  }) : _tags = tags,
       super._();

  factory _$NewsItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsItemImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @override
  final String title;
  @override
  @JsonKey()
  final String subtitle;
  @override
  final String slug;
  @override
  @JsonKey()
  final String summary;
  @override
  @JsonKey()
  final String content;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey(name: 'video_url')
  final String videoUrl;
  @override
  @JsonKey()
  final String author;
  @override
  @JsonKey()
  final String source;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey(name: 'is_featured')
  final bool isFeatured;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'published_at')
  final DateTime? publishedAt;
  @override
  @JsonKey(name: 'views_count')
  final int viewsCount;
  @override
  @JsonKey(name: 'likes_count')
  final int likesCount;
  @override
  @JsonKey(name: 'comments_count')
  final int commentsCount;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'category_color')
  final String? categoryColor;
  @override
  @JsonKey(name: 'category_icon')
  final String? categoryIcon;

  @override
  String toString() {
    return 'NewsItem(id: $id, categoryId: $categoryId, title: $title, subtitle: $subtitle, slug: $slug, summary: $summary, content: $content, imageUrl: $imageUrl, videoUrl: $videoUrl, author: $author, source: $source, tags: $tags, isFeatured: $isFeatured, status: $status, publishedAt: $publishedAt, viewsCount: $viewsCount, likesCount: $likesCount, commentsCount: $commentsCount, createdAt: $createdAt, updatedAt: $updatedAt, categoryName: $categoryName, categoryColor: $categoryColor, categoryIcon: $categoryIcon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.source, source) || other.source == source) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.viewsCount, viewsCount) ||
                other.viewsCount == viewsCount) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categoryColor, categoryColor) ||
                other.categoryColor == categoryColor) &&
            (identical(other.categoryIcon, categoryIcon) ||
                other.categoryIcon == categoryIcon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    categoryId,
    title,
    subtitle,
    slug,
    summary,
    content,
    imageUrl,
    videoUrl,
    author,
    source,
    const DeepCollectionEquality().hash(_tags),
    isFeatured,
    status,
    publishedAt,
    viewsCount,
    likesCount,
    commentsCount,
    createdAt,
    updatedAt,
    categoryName,
    categoryColor,
    categoryIcon,
  ]);

  /// Create a copy of NewsItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsItemImplCopyWith<_$NewsItemImpl> get copyWith =>
      __$$NewsItemImplCopyWithImpl<_$NewsItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsItemImplToJson(this);
  }
}

abstract class _NewsItem extends NewsItem {
  const factory _NewsItem({
    final String? id,
    @JsonKey(name: 'category_id') final String? categoryId,
    required final String title,
    final String subtitle,
    required final String slug,
    final String summary,
    final String content,
    @JsonKey(name: 'image_url') final String imageUrl,
    @JsonKey(name: 'video_url') final String videoUrl,
    final String author,
    final String source,
    final List<String> tags,
    @JsonKey(name: 'is_featured') final bool isFeatured,
    final String status,
    @JsonKey(name: 'published_at') final DateTime? publishedAt,
    @JsonKey(name: 'views_count') final int viewsCount,
    @JsonKey(name: 'likes_count') final int likesCount,
    @JsonKey(name: 'comments_count') final int commentsCount,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
    @JsonKey(name: 'category_name') final String? categoryName,
    @JsonKey(name: 'category_color') final String? categoryColor,
    @JsonKey(name: 'category_icon') final String? categoryIcon,
  }) = _$NewsItemImpl;
  const _NewsItem._() : super._();

  factory _NewsItem.fromJson(Map<String, dynamic> json) =
      _$NewsItemImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'category_id')
  String? get categoryId;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get slug;
  @override
  String get summary;
  @override
  String get content;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  @JsonKey(name: 'video_url')
  String get videoUrl;
  @override
  String get author;
  @override
  String get source;
  @override
  List<String> get tags;
  @override
  @JsonKey(name: 'is_featured')
  bool get isFeatured;
  @override
  String get status;
  @override
  @JsonKey(name: 'published_at')
  DateTime? get publishedAt;
  @override
  @JsonKey(name: 'views_count')
  int get viewsCount;
  @override
  @JsonKey(name: 'likes_count')
  int get likesCount;
  @override
  @JsonKey(name: 'comments_count')
  int get commentsCount;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'category_color')
  String? get categoryColor;
  @override
  @JsonKey(name: 'category_icon')
  String? get categoryIcon;

  /// Create a copy of NewsItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsItemImplCopyWith<_$NewsItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlanCategory _$PlanCategoryFromJson(Map<String, dynamic> json) {
  return _PlanCategory.fromJson(json);
}

/// @nodoc
mixin _$PlanCategory {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'icon')
  String get icon => throw _privateConstructorUsedError;
  @JsonKey(name: 'color')
  String get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this PlanCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlanCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanCategoryCopyWith<PlanCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanCategoryCopyWith<$Res> {
  factory $PlanCategoryCopyWith(
    PlanCategory value,
    $Res Function(PlanCategory) then,
  ) = _$PlanCategoryCopyWithImpl<$Res, PlanCategory>;
  @useResult
  $Res call({
    String? id,
    String? name,
    String? slug,
    @JsonKey(name: 'icon') String icon,
    @JsonKey(name: 'color') String color,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$PlanCategoryCopyWithImpl<$Res, $Val extends PlanCategory>
    implements $PlanCategoryCopyWith<$Res> {
  _$PlanCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlanCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
    Object? icon = null,
    Object? color = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            slug: freezed == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String?,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlanCategoryImplCopyWith<$Res>
    implements $PlanCategoryCopyWith<$Res> {
  factory _$$PlanCategoryImplCopyWith(
    _$PlanCategoryImpl value,
    $Res Function(_$PlanCategoryImpl) then,
  ) = __$$PlanCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? name,
    String? slug,
    @JsonKey(name: 'icon') String icon,
    @JsonKey(name: 'color') String color,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$PlanCategoryImplCopyWithImpl<$Res>
    extends _$PlanCategoryCopyWithImpl<$Res, _$PlanCategoryImpl>
    implements _$$PlanCategoryImplCopyWith<$Res> {
  __$$PlanCategoryImplCopyWithImpl(
    _$PlanCategoryImpl _value,
    $Res Function(_$PlanCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlanCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
    Object? icon = null,
    Object? color = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _$PlanCategoryImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        slug: freezed == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String?,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlanCategoryImpl implements _PlanCategory {
  const _$PlanCategoryImpl({
    this.id,
    this.name,
    this.slug,
    @JsonKey(name: 'icon') this.icon = 'category_rounded',
    @JsonKey(name: 'color') this.color = '#1565C0',
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$PlanCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlanCategoryImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? slug;
  @override
  @JsonKey(name: 'icon')
  final String icon;
  @override
  @JsonKey(name: 'color')
  final String color;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'PlanCategory(id: $id, name: $name, slug: $slug, icon: $icon, color: $color, sortOrder: $sortOrder, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    slug,
    icon,
    color,
    sortOrder,
    isActive,
  );

  /// Create a copy of PlanCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanCategoryImplCopyWith<_$PlanCategoryImpl> get copyWith =>
      __$$PlanCategoryImplCopyWithImpl<_$PlanCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlanCategoryImplToJson(this);
  }
}

abstract class _PlanCategory implements PlanCategory {
  const factory _PlanCategory({
    final String? id,
    final String? name,
    final String? slug,
    @JsonKey(name: 'icon') final String icon,
    @JsonKey(name: 'color') final String color,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$PlanCategoryImpl;

  factory _PlanCategory.fromJson(Map<String, dynamic> json) =
      _$PlanCategoryImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get slug;
  @override
  @JsonKey(name: 'icon')
  String get icon;
  @override
  @JsonKey(name: 'color')
  String get color;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of PlanCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanCategoryImplCopyWith<_$PlanCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GovernmentPlan _$GovernmentPlanFromJson(Map<String, dynamic> json) {
  return _GovernmentPlan.fromJson(json);
}

/// @nodoc
mixin _$GovernmentPlan {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String? get categoryId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get objectives => throw _privateConstructorUsedError;
  List<String> get benefits => throw _privateConstructorUsedError;
  String get impact => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  String get tone => throw _privateConstructorUsedError;
  @JsonKey(name: 'pdf_url')
  String get pdfUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_featured')
  bool get isFeatured => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_icon')
  String? get categoryIcon => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_color')
  String? get categoryColor => throw _privateConstructorUsedError;

  /// Serializes this GovernmentPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GovernmentPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GovernmentPlanCopyWith<GovernmentPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GovernmentPlanCopyWith<$Res> {
  factory $GovernmentPlanCopyWith(
    GovernmentPlan value,
    $Res Function(GovernmentPlan) then,
  ) = _$GovernmentPlanCopyWithImpl<$Res, GovernmentPlan>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'category_id') String? categoryId,
    String title,
    String slug,
    String summary,
    String description,
    List<String> objectives,
    List<String> benefits,
    String impact,
    String status,
    int progress,
    String tone,
    @JsonKey(name: 'pdf_url') String pdfUrl,
    @JsonKey(name: 'is_featured') bool isFeatured,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_icon') String? categoryIcon,
    @JsonKey(name: 'category_color') String? categoryColor,
  });
}

/// @nodoc
class _$GovernmentPlanCopyWithImpl<$Res, $Val extends GovernmentPlan>
    implements $GovernmentPlanCopyWith<$Res> {
  _$GovernmentPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GovernmentPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? categoryId = freezed,
    Object? title = null,
    Object? slug = null,
    Object? summary = null,
    Object? description = null,
    Object? objectives = null,
    Object? benefits = null,
    Object? impact = null,
    Object? status = null,
    Object? progress = null,
    Object? tone = null,
    Object? pdfUrl = null,
    Object? isFeatured = null,
    Object? sortOrder = null,
    Object? isActive = null,
    Object? categoryName = freezed,
    Object? categoryIcon = freezed,
    Object? categoryColor = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            objectives: null == objectives
                ? _value.objectives
                : objectives // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            benefits: null == benefits
                ? _value.benefits
                : benefits // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            impact: null == impact
                ? _value.impact
                : impact // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as int,
            tone: null == tone
                ? _value.tone
                : tone // ignore: cast_nullable_to_non_nullable
                      as String,
            pdfUrl: null == pdfUrl
                ? _value.pdfUrl
                : pdfUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryIcon: freezed == categoryIcon
                ? _value.categoryIcon
                : categoryIcon // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryColor: freezed == categoryColor
                ? _value.categoryColor
                : categoryColor // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GovernmentPlanImplCopyWith<$Res>
    implements $GovernmentPlanCopyWith<$Res> {
  factory _$$GovernmentPlanImplCopyWith(
    _$GovernmentPlanImpl value,
    $Res Function(_$GovernmentPlanImpl) then,
  ) = __$$GovernmentPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'category_id') String? categoryId,
    String title,
    String slug,
    String summary,
    String description,
    List<String> objectives,
    List<String> benefits,
    String impact,
    String status,
    int progress,
    String tone,
    @JsonKey(name: 'pdf_url') String pdfUrl,
    @JsonKey(name: 'is_featured') bool isFeatured,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_icon') String? categoryIcon,
    @JsonKey(name: 'category_color') String? categoryColor,
  });
}

/// @nodoc
class __$$GovernmentPlanImplCopyWithImpl<$Res>
    extends _$GovernmentPlanCopyWithImpl<$Res, _$GovernmentPlanImpl>
    implements _$$GovernmentPlanImplCopyWith<$Res> {
  __$$GovernmentPlanImplCopyWithImpl(
    _$GovernmentPlanImpl _value,
    $Res Function(_$GovernmentPlanImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GovernmentPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? categoryId = freezed,
    Object? title = null,
    Object? slug = null,
    Object? summary = null,
    Object? description = null,
    Object? objectives = null,
    Object? benefits = null,
    Object? impact = null,
    Object? status = null,
    Object? progress = null,
    Object? tone = null,
    Object? pdfUrl = null,
    Object? isFeatured = null,
    Object? sortOrder = null,
    Object? isActive = null,
    Object? categoryName = freezed,
    Object? categoryIcon = freezed,
    Object? categoryColor = freezed,
  }) {
    return _then(
      _$GovernmentPlanImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        objectives: null == objectives
            ? _value._objectives
            : objectives // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        benefits: null == benefits
            ? _value._benefits
            : benefits // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        impact: null == impact
            ? _value.impact
            : impact // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as int,
        tone: null == tone
            ? _value.tone
            : tone // ignore: cast_nullable_to_non_nullable
                  as String,
        pdfUrl: null == pdfUrl
            ? _value.pdfUrl
            : pdfUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryIcon: freezed == categoryIcon
            ? _value.categoryIcon
            : categoryIcon // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryColor: freezed == categoryColor
            ? _value.categoryColor
            : categoryColor // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GovernmentPlanImpl extends _GovernmentPlan {
  const _$GovernmentPlanImpl({
    this.id,
    @JsonKey(name: 'category_id') this.categoryId,
    required this.title,
    required this.slug,
    this.summary = '',
    this.description = '',
    final List<String> objectives = const [],
    final List<String> benefits = const [],
    this.impact = '',
    this.status = 'planejado',
    this.progress = 0,
    this.tone = 'primary',
    @JsonKey(name: 'pdf_url') this.pdfUrl = '',
    @JsonKey(name: 'is_featured') this.isFeatured = false,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'is_active') this.isActive = true,
    @JsonKey(name: 'category_name') this.categoryName,
    @JsonKey(name: 'category_icon') this.categoryIcon,
    @JsonKey(name: 'category_color') this.categoryColor,
  }) : _objectives = objectives,
       _benefits = benefits,
       super._();

  factory _$GovernmentPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$GovernmentPlanImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @override
  final String title;
  @override
  final String slug;
  @override
  @JsonKey()
  final String summary;
  @override
  @JsonKey()
  final String description;
  final List<String> _objectives;
  @override
  @JsonKey()
  List<String> get objectives {
    if (_objectives is EqualUnmodifiableListView) return _objectives;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_objectives);
  }

  final List<String> _benefits;
  @override
  @JsonKey()
  List<String> get benefits {
    if (_benefits is EqualUnmodifiableListView) return _benefits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_benefits);
  }

  @override
  @JsonKey()
  final String impact;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final int progress;
  @override
  @JsonKey()
  final String tone;
  @override
  @JsonKey(name: 'pdf_url')
  final String pdfUrl;
  @override
  @JsonKey(name: 'is_featured')
  final bool isFeatured;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'category_icon')
  final String? categoryIcon;
  @override
  @JsonKey(name: 'category_color')
  final String? categoryColor;

  @override
  String toString() {
    return 'GovernmentPlan(id: $id, categoryId: $categoryId, title: $title, slug: $slug, summary: $summary, description: $description, objectives: $objectives, benefits: $benefits, impact: $impact, status: $status, progress: $progress, tone: $tone, pdfUrl: $pdfUrl, isFeatured: $isFeatured, sortOrder: $sortOrder, isActive: $isActive, categoryName: $categoryName, categoryIcon: $categoryIcon, categoryColor: $categoryColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GovernmentPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._objectives,
              _objectives,
            ) &&
            const DeepCollectionEquality().equals(other._benefits, _benefits) &&
            (identical(other.impact, impact) || other.impact == impact) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.pdfUrl, pdfUrl) || other.pdfUrl == pdfUrl) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categoryIcon, categoryIcon) ||
                other.categoryIcon == categoryIcon) &&
            (identical(other.categoryColor, categoryColor) ||
                other.categoryColor == categoryColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    categoryId,
    title,
    slug,
    summary,
    description,
    const DeepCollectionEquality().hash(_objectives),
    const DeepCollectionEquality().hash(_benefits),
    impact,
    status,
    progress,
    tone,
    pdfUrl,
    isFeatured,
    sortOrder,
    isActive,
    categoryName,
    categoryIcon,
    categoryColor,
  ]);

  /// Create a copy of GovernmentPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GovernmentPlanImplCopyWith<_$GovernmentPlanImpl> get copyWith =>
      __$$GovernmentPlanImplCopyWithImpl<_$GovernmentPlanImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GovernmentPlanImplToJson(this);
  }
}

abstract class _GovernmentPlan extends GovernmentPlan {
  const factory _GovernmentPlan({
    final String? id,
    @JsonKey(name: 'category_id') final String? categoryId,
    required final String title,
    required final String slug,
    final String summary,
    final String description,
    final List<String> objectives,
    final List<String> benefits,
    final String impact,
    final String status,
    final int progress,
    final String tone,
    @JsonKey(name: 'pdf_url') final String pdfUrl,
    @JsonKey(name: 'is_featured') final bool isFeatured,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'is_active') final bool isActive,
    @JsonKey(name: 'category_name') final String? categoryName,
    @JsonKey(name: 'category_icon') final String? categoryIcon,
    @JsonKey(name: 'category_color') final String? categoryColor,
  }) = _$GovernmentPlanImpl;
  const _GovernmentPlan._() : super._();

  factory _GovernmentPlan.fromJson(Map<String, dynamic> json) =
      _$GovernmentPlanImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'category_id')
  String? get categoryId;
  @override
  String get title;
  @override
  String get slug;
  @override
  String get summary;
  @override
  String get description;
  @override
  List<String> get objectives;
  @override
  List<String> get benefits;
  @override
  String get impact;
  @override
  String get status;
  @override
  int get progress;
  @override
  String get tone;
  @override
  @JsonKey(name: 'pdf_url')
  String get pdfUrl;
  @override
  @JsonKey(name: 'is_featured')
  bool get isFeatured;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'category_icon')
  String? get categoryIcon;
  @override
  @JsonKey(name: 'category_color')
  String? get categoryColor;

  /// Create a copy of GovernmentPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GovernmentPlanImplCopyWith<_$GovernmentPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

City _$CityFromJson(Map<String, dynamic> json) {
  return _City.fromJson(json);
}

/// @nodoc
mixin _$City {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'state')
  String get state => throw _privateConstructorUsedError;
  String get region => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  int get population => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this City to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of City
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CityCopyWith<City> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CityCopyWith<$Res> {
  factory $CityCopyWith(City value, $Res Function(City) then) =
      _$CityCopyWithImpl<$Res, City>;
  @useResult
  $Res call({
    String? id,
    String name,
    String slug,
    @JsonKey(name: 'state') String state,
    String region,
    double latitude,
    double longitude,
    int population,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$CityCopyWithImpl<$Res, $Val extends City>
    implements $CityCopyWith<$Res> {
  _$CityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of City
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? slug = null,
    Object? state = null,
    Object? region = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? population = null,
    Object? imageUrl = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String,
            region: null == region
                ? _value.region
                : region // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            population: null == population
                ? _value.population
                : population // ignore: cast_nullable_to_non_nullable
                      as int,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CityImplCopyWith<$Res> implements $CityCopyWith<$Res> {
  factory _$$CityImplCopyWith(
    _$CityImpl value,
    $Res Function(_$CityImpl) then,
  ) = __$$CityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String name,
    String slug,
    @JsonKey(name: 'state') String state,
    String region,
    double latitude,
    double longitude,
    int population,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$CityImplCopyWithImpl<$Res>
    extends _$CityCopyWithImpl<$Res, _$CityImpl>
    implements _$$CityImplCopyWith<$Res> {
  __$$CityImplCopyWithImpl(_$CityImpl _value, $Res Function(_$CityImpl) _then)
    : super(_value, _then);

  /// Create a copy of City
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? slug = null,
    Object? state = null,
    Object? region = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? population = null,
    Object? imageUrl = null,
    Object? isActive = null,
  }) {
    return _then(
      _$CityImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        state: null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String,
        region: null == region
            ? _value.region
            : region // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        population: null == population
            ? _value.population
            : population // ignore: cast_nullable_to_non_nullable
                  as int,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CityImpl implements _City {
  const _$CityImpl({
    this.id,
    required this.name,
    required this.slug,
    @JsonKey(name: 'state') this.state = 'BA',
    this.region = '',
    this.latitude = 0,
    this.longitude = 0,
    this.population = 0,
    @JsonKey(name: 'image_url') this.imageUrl = '',
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$CityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CityImplFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String slug;
  @override
  @JsonKey(name: 'state')
  final String state;
  @override
  @JsonKey()
  final String region;
  @override
  @JsonKey()
  final double latitude;
  @override
  @JsonKey()
  final double longitude;
  @override
  @JsonKey()
  final int population;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'City(id: $id, name: $name, slug: $slug, state: $state, region: $region, latitude: $latitude, longitude: $longitude, population: $population, imageUrl: $imageUrl, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.population, population) ||
                other.population == population) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    slug,
    state,
    region,
    latitude,
    longitude,
    population,
    imageUrl,
    isActive,
  );

  /// Create a copy of City
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CityImplCopyWith<_$CityImpl> get copyWith =>
      __$$CityImplCopyWithImpl<_$CityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CityImplToJson(this);
  }
}

abstract class _City implements City {
  const factory _City({
    final String? id,
    required final String name,
    required final String slug,
    @JsonKey(name: 'state') final String state,
    final String region,
    final double latitude,
    final double longitude,
    final int population,
    @JsonKey(name: 'image_url') final String imageUrl,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$CityImpl;

  factory _City.fromJson(Map<String, dynamic> json) = _$CityImpl.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String get slug;
  @override
  @JsonKey(name: 'state')
  String get state;
  @override
  String get region;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  int get population;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of City
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CityImplCopyWith<_$CityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventItem _$EventItemFromJson(Map<String, dynamic> json) {
  return _EventItem.fromJson(json);
}

/// @nodoc
mixin _$EventItem {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'city_id')
  String? get cityId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_name')
  String get locationName => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'starts_at')
  DateTime get startsAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'ends_at')
  DateTime? get endsAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_type')
  String get eventType => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'rsvp_count')
  int get rsvpCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_featured')
  bool get isFeatured => throw _privateConstructorUsedError;
  @JsonKey(name: 'city_name')
  String? get cityName => throw _privateConstructorUsedError;
  @JsonKey(name: 'city_region')
  String? get cityRegion => throw _privateConstructorUsedError;
  @JsonKey(name: 'city_latitude')
  double? get cityLatitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'city_longitude')
  double? get cityLongitude => throw _privateConstructorUsedError;

  /// Serializes this EventItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventItemCopyWith<EventItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventItemCopyWith<$Res> {
  factory $EventItemCopyWith(EventItem value, $Res Function(EventItem) then) =
      _$EventItemCopyWithImpl<$Res, EventItem>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'city_id') String? cityId,
    String title,
    String description,
    @JsonKey(name: 'location_name') String locationName,
    String address,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'starts_at') DateTime startsAt,
    @JsonKey(name: 'ends_at') DateTime? endsAt,
    @JsonKey(name: 'event_type') String eventType,
    String status,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'rsvp_count') int rsvpCount,
    @JsonKey(name: 'is_featured') bool isFeatured,
    @JsonKey(name: 'city_name') String? cityName,
    @JsonKey(name: 'city_region') String? cityRegion,
    @JsonKey(name: 'city_latitude') double? cityLatitude,
    @JsonKey(name: 'city_longitude') double? cityLongitude,
  });
}

/// @nodoc
class _$EventItemCopyWithImpl<$Res, $Val extends EventItem>
    implements $EventItemCopyWith<$Res> {
  _$EventItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? cityId = freezed,
    Object? title = null,
    Object? description = null,
    Object? locationName = null,
    Object? address = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? startsAt = null,
    Object? endsAt = freezed,
    Object? eventType = null,
    Object? status = null,
    Object? imageUrl = null,
    Object? rsvpCount = null,
    Object? isFeatured = null,
    Object? cityName = freezed,
    Object? cityRegion = freezed,
    Object? cityLatitude = freezed,
    Object? cityLongitude = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            cityId: freezed == cityId
                ? _value.cityId
                : cityId // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            locationName: null == locationName
                ? _value.locationName
                : locationName // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            startsAt: null == startsAt
                ? _value.startsAt
                : startsAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endsAt: freezed == endsAt
                ? _value.endsAt
                : endsAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            eventType: null == eventType
                ? _value.eventType
                : eventType // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            rsvpCount: null == rsvpCount
                ? _value.rsvpCount
                : rsvpCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
            cityName: freezed == cityName
                ? _value.cityName
                : cityName // ignore: cast_nullable_to_non_nullable
                      as String?,
            cityRegion: freezed == cityRegion
                ? _value.cityRegion
                : cityRegion // ignore: cast_nullable_to_non_nullable
                      as String?,
            cityLatitude: freezed == cityLatitude
                ? _value.cityLatitude
                : cityLatitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            cityLongitude: freezed == cityLongitude
                ? _value.cityLongitude
                : cityLongitude // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EventItemImplCopyWith<$Res>
    implements $EventItemCopyWith<$Res> {
  factory _$$EventItemImplCopyWith(
    _$EventItemImpl value,
    $Res Function(_$EventItemImpl) then,
  ) = __$$EventItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'city_id') String? cityId,
    String title,
    String description,
    @JsonKey(name: 'location_name') String locationName,
    String address,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'starts_at') DateTime startsAt,
    @JsonKey(name: 'ends_at') DateTime? endsAt,
    @JsonKey(name: 'event_type') String eventType,
    String status,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'rsvp_count') int rsvpCount,
    @JsonKey(name: 'is_featured') bool isFeatured,
    @JsonKey(name: 'city_name') String? cityName,
    @JsonKey(name: 'city_region') String? cityRegion,
    @JsonKey(name: 'city_latitude') double? cityLatitude,
    @JsonKey(name: 'city_longitude') double? cityLongitude,
  });
}

/// @nodoc
class __$$EventItemImplCopyWithImpl<$Res>
    extends _$EventItemCopyWithImpl<$Res, _$EventItemImpl>
    implements _$$EventItemImplCopyWith<$Res> {
  __$$EventItemImplCopyWithImpl(
    _$EventItemImpl _value,
    $Res Function(_$EventItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EventItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? cityId = freezed,
    Object? title = null,
    Object? description = null,
    Object? locationName = null,
    Object? address = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? startsAt = null,
    Object? endsAt = freezed,
    Object? eventType = null,
    Object? status = null,
    Object? imageUrl = null,
    Object? rsvpCount = null,
    Object? isFeatured = null,
    Object? cityName = freezed,
    Object? cityRegion = freezed,
    Object? cityLatitude = freezed,
    Object? cityLongitude = freezed,
  }) {
    return _then(
      _$EventItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        cityId: freezed == cityId
            ? _value.cityId
            : cityId // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        locationName: null == locationName
            ? _value.locationName
            : locationName // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        startsAt: null == startsAt
            ? _value.startsAt
            : startsAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endsAt: freezed == endsAt
            ? _value.endsAt
            : endsAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        eventType: null == eventType
            ? _value.eventType
            : eventType // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        rsvpCount: null == rsvpCount
            ? _value.rsvpCount
            : rsvpCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
        cityName: freezed == cityName
            ? _value.cityName
            : cityName // ignore: cast_nullable_to_non_nullable
                  as String?,
        cityRegion: freezed == cityRegion
            ? _value.cityRegion
            : cityRegion // ignore: cast_nullable_to_non_nullable
                  as String?,
        cityLatitude: freezed == cityLatitude
            ? _value.cityLatitude
            : cityLatitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        cityLongitude: freezed == cityLongitude
            ? _value.cityLongitude
            : cityLongitude // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EventItemImpl extends _EventItem {
  const _$EventItemImpl({
    this.id,
    @JsonKey(name: 'city_id') this.cityId,
    required this.title,
    this.description = '',
    @JsonKey(name: 'location_name') this.locationName = '',
    this.address = '',
    this.latitude,
    this.longitude,
    @JsonKey(name: 'starts_at') required this.startsAt,
    @JsonKey(name: 'ends_at') this.endsAt,
    @JsonKey(name: 'event_type') this.eventType = 'outro',
    this.status = 'agendado',
    @JsonKey(name: 'image_url') this.imageUrl = '',
    @JsonKey(name: 'rsvp_count') this.rsvpCount = 0,
    @JsonKey(name: 'is_featured') this.isFeatured = false,
    @JsonKey(name: 'city_name') this.cityName,
    @JsonKey(name: 'city_region') this.cityRegion,
    @JsonKey(name: 'city_latitude') this.cityLatitude,
    @JsonKey(name: 'city_longitude') this.cityLongitude,
  }) : super._();

  factory _$EventItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventItemImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'city_id')
  final String? cityId;
  @override
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(name: 'location_name')
  final String locationName;
  @override
  @JsonKey()
  final String address;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey(name: 'starts_at')
  final DateTime startsAt;
  @override
  @JsonKey(name: 'ends_at')
  final DateTime? endsAt;
  @override
  @JsonKey(name: 'event_type')
  final String eventType;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey(name: 'rsvp_count')
  final int rsvpCount;
  @override
  @JsonKey(name: 'is_featured')
  final bool isFeatured;
  @override
  @JsonKey(name: 'city_name')
  final String? cityName;
  @override
  @JsonKey(name: 'city_region')
  final String? cityRegion;
  @override
  @JsonKey(name: 'city_latitude')
  final double? cityLatitude;
  @override
  @JsonKey(name: 'city_longitude')
  final double? cityLongitude;

  @override
  String toString() {
    return 'EventItem(id: $id, cityId: $cityId, title: $title, description: $description, locationName: $locationName, address: $address, latitude: $latitude, longitude: $longitude, startsAt: $startsAt, endsAt: $endsAt, eventType: $eventType, status: $status, imageUrl: $imageUrl, rsvpCount: $rsvpCount, isFeatured: $isFeatured, cityName: $cityName, cityRegion: $cityRegion, cityLatitude: $cityLatitude, cityLongitude: $cityLongitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cityId, cityId) || other.cityId == cityId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.locationName, locationName) ||
                other.locationName == locationName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.startsAt, startsAt) ||
                other.startsAt == startsAt) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.rsvpCount, rsvpCount) ||
                other.rsvpCount == rsvpCount) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.cityName, cityName) ||
                other.cityName == cityName) &&
            (identical(other.cityRegion, cityRegion) ||
                other.cityRegion == cityRegion) &&
            (identical(other.cityLatitude, cityLatitude) ||
                other.cityLatitude == cityLatitude) &&
            (identical(other.cityLongitude, cityLongitude) ||
                other.cityLongitude == cityLongitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    cityId,
    title,
    description,
    locationName,
    address,
    latitude,
    longitude,
    startsAt,
    endsAt,
    eventType,
    status,
    imageUrl,
    rsvpCount,
    isFeatured,
    cityName,
    cityRegion,
    cityLatitude,
    cityLongitude,
  ]);

  /// Create a copy of EventItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventItemImplCopyWith<_$EventItemImpl> get copyWith =>
      __$$EventItemImplCopyWithImpl<_$EventItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventItemImplToJson(this);
  }
}

abstract class _EventItem extends EventItem {
  const factory _EventItem({
    final String? id,
    @JsonKey(name: 'city_id') final String? cityId,
    required final String title,
    final String description,
    @JsonKey(name: 'location_name') final String locationName,
    final String address,
    final double? latitude,
    final double? longitude,
    @JsonKey(name: 'starts_at') required final DateTime startsAt,
    @JsonKey(name: 'ends_at') final DateTime? endsAt,
    @JsonKey(name: 'event_type') final String eventType,
    final String status,
    @JsonKey(name: 'image_url') final String imageUrl,
    @JsonKey(name: 'rsvp_count') final int rsvpCount,
    @JsonKey(name: 'is_featured') final bool isFeatured,
    @JsonKey(name: 'city_name') final String? cityName,
    @JsonKey(name: 'city_region') final String? cityRegion,
    @JsonKey(name: 'city_latitude') final double? cityLatitude,
    @JsonKey(name: 'city_longitude') final double? cityLongitude,
  }) = _$EventItemImpl;
  const _EventItem._() : super._();

  factory _EventItem.fromJson(Map<String, dynamic> json) =
      _$EventItemImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'city_id')
  String? get cityId;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'location_name')
  String get locationName;
  @override
  String get address;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  @JsonKey(name: 'starts_at')
  DateTime get startsAt;
  @override
  @JsonKey(name: 'ends_at')
  DateTime? get endsAt;
  @override
  @JsonKey(name: 'event_type')
  String get eventType;
  @override
  String get status;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  @JsonKey(name: 'rsvp_count')
  int get rsvpCount;
  @override
  @JsonKey(name: 'is_featured')
  bool get isFeatured;
  @override
  @JsonKey(name: 'city_name')
  String? get cityName;
  @override
  @JsonKey(name: 'city_region')
  String? get cityRegion;
  @override
  @JsonKey(name: 'city_latitude')
  double? get cityLatitude;
  @override
  @JsonKey(name: 'city_longitude')
  double? get cityLongitude;

  /// Create a copy of EventItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventItemImplCopyWith<_$EventItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GalleryItem _$GalleryItemFromJson(Map<String, dynamic> json) {
  return _GalleryItem.fromJson(json);
}

/// @nodoc
mixin _$GalleryItem {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'video_url')
  String get videoUrl => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get album => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_video')
  bool get isVideo => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_story')
  bool get isStory => throw _privateConstructorUsedError;
  @JsonKey(name: 'likes_count')
  int get likesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this GalleryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GalleryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GalleryItemCopyWith<GalleryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GalleryItemCopyWith<$Res> {
  factory $GalleryItemCopyWith(
    GalleryItem value,
    $Res Function(GalleryItem) then,
  ) = _$GalleryItemCopyWithImpl<$Res, GalleryItem>;
  @useResult
  $Res call({
    String? id,
    String title,
    String description,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'video_url') String videoUrl,
    String category,
    String album,
    @JsonKey(name: 'is_video') bool isVideo,
    @JsonKey(name: 'is_story') bool isStory,
    @JsonKey(name: 'likes_count') int likesCount,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$GalleryItemCopyWithImpl<$Res, $Val extends GalleryItem>
    implements $GalleryItemCopyWith<$Res> {
  _$GalleryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GalleryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? videoUrl = null,
    Object? category = null,
    Object? album = null,
    Object? isVideo = null,
    Object? isStory = null,
    Object? likesCount = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            videoUrl: null == videoUrl
                ? _value.videoUrl
                : videoUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            album: null == album
                ? _value.album
                : album // ignore: cast_nullable_to_non_nullable
                      as String,
            isVideo: null == isVideo
                ? _value.isVideo
                : isVideo // ignore: cast_nullable_to_non_nullable
                      as bool,
            isStory: null == isStory
                ? _value.isStory
                : isStory // ignore: cast_nullable_to_non_nullable
                      as bool,
            likesCount: null == likesCount
                ? _value.likesCount
                : likesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GalleryItemImplCopyWith<$Res>
    implements $GalleryItemCopyWith<$Res> {
  factory _$$GalleryItemImplCopyWith(
    _$GalleryItemImpl value,
    $Res Function(_$GalleryItemImpl) then,
  ) = __$$GalleryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String title,
    String description,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'video_url') String videoUrl,
    String category,
    String album,
    @JsonKey(name: 'is_video') bool isVideo,
    @JsonKey(name: 'is_story') bool isStory,
    @JsonKey(name: 'likes_count') int likesCount,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$GalleryItemImplCopyWithImpl<$Res>
    extends _$GalleryItemCopyWithImpl<$Res, _$GalleryItemImpl>
    implements _$$GalleryItemImplCopyWith<$Res> {
  __$$GalleryItemImplCopyWithImpl(
    _$GalleryItemImpl _value,
    $Res Function(_$GalleryItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GalleryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? videoUrl = null,
    Object? category = null,
    Object? album = null,
    Object? isVideo = null,
    Object? isStory = null,
    Object? likesCount = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _$GalleryItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        videoUrl: null == videoUrl
            ? _value.videoUrl
            : videoUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        album: null == album
            ? _value.album
            : album // ignore: cast_nullable_to_non_nullable
                  as String,
        isVideo: null == isVideo
            ? _value.isVideo
            : isVideo // ignore: cast_nullable_to_non_nullable
                  as bool,
        isStory: null == isStory
            ? _value.isStory
            : isStory // ignore: cast_nullable_to_non_nullable
                  as bool,
        likesCount: null == likesCount
            ? _value.likesCount
            : likesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GalleryItemImpl implements _GalleryItem {
  const _$GalleryItemImpl({
    this.id,
    this.title = '',
    this.description = '',
    @JsonKey(name: 'image_url') this.imageUrl = '',
    @JsonKey(name: 'video_url') this.videoUrl = '',
    this.category = 'geral',
    this.album = '',
    @JsonKey(name: 'is_video') this.isVideo = false,
    @JsonKey(name: 'is_story') this.isStory = false,
    @JsonKey(name: 'likes_count') this.likesCount = 0,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$GalleryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$GalleryItemImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey(name: 'video_url')
  final String videoUrl;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey()
  final String album;
  @override
  @JsonKey(name: 'is_video')
  final bool isVideo;
  @override
  @JsonKey(name: 'is_story')
  final bool isStory;
  @override
  @JsonKey(name: 'likes_count')
  final int likesCount;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'GalleryItem(id: $id, title: $title, description: $description, imageUrl: $imageUrl, videoUrl: $videoUrl, category: $category, album: $album, isVideo: $isVideo, isStory: $isStory, likesCount: $likesCount, sortOrder: $sortOrder, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GalleryItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.album, album) || other.album == album) &&
            (identical(other.isVideo, isVideo) || other.isVideo == isVideo) &&
            (identical(other.isStory, isStory) || other.isStory == isStory) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    imageUrl,
    videoUrl,
    category,
    album,
    isVideo,
    isStory,
    likesCount,
    sortOrder,
    isActive,
  );

  /// Create a copy of GalleryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GalleryItemImplCopyWith<_$GalleryItemImpl> get copyWith =>
      __$$GalleryItemImplCopyWithImpl<_$GalleryItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GalleryItemImplToJson(this);
  }
}

abstract class _GalleryItem implements GalleryItem {
  const factory _GalleryItem({
    final String? id,
    final String title,
    final String description,
    @JsonKey(name: 'image_url') final String imageUrl,
    @JsonKey(name: 'video_url') final String videoUrl,
    final String category,
    final String album,
    @JsonKey(name: 'is_video') final bool isVideo,
    @JsonKey(name: 'is_story') final bool isStory,
    @JsonKey(name: 'likes_count') final int likesCount,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$GalleryItemImpl;

  factory _GalleryItem.fromJson(Map<String, dynamic> json) =
      _$GalleryItemImpl.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  @JsonKey(name: 'video_url')
  String get videoUrl;
  @override
  String get category;
  @override
  String get album;
  @override
  @JsonKey(name: 'is_video')
  bool get isVideo;
  @override
  @JsonKey(name: 'is_story')
  bool get isStory;
  @override
  @JsonKey(name: 'likes_count')
  int get likesCount;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of GalleryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GalleryItemImplCopyWith<_$GalleryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VideoItem _$VideoItemFromJson(Map<String, dynamic> json) {
  return _VideoItem.fromJson(json);
}

/// @nodoc
mixin _$VideoItem {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'youtube_id')
  String get youtubeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'video_url')
  String get videoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'thumbnail_url')
  String get thumbnailUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'video_type')
  String get videoType => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_seconds')
  int get durationSeconds => throw _privateConstructorUsedError;
  @JsonKey(name: 'views_count')
  int get viewsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_featured')
  bool get isFeatured => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this VideoItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VideoItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoItemCopyWith<VideoItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoItemCopyWith<$Res> {
  factory $VideoItemCopyWith(VideoItem value, $Res Function(VideoItem) then) =
      _$VideoItemCopyWithImpl<$Res, VideoItem>;
  @useResult
  $Res call({
    String? id,
    String title,
    String description,
    @JsonKey(name: 'youtube_id') String youtubeId,
    @JsonKey(name: 'video_url') String videoUrl,
    @JsonKey(name: 'thumbnail_url') String thumbnailUrl,
    @JsonKey(name: 'video_type') String videoType,
    String category,
    @JsonKey(name: 'duration_seconds') int durationSeconds,
    @JsonKey(name: 'views_count') int viewsCount,
    @JsonKey(name: 'is_featured') bool isFeatured,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$VideoItemCopyWithImpl<$Res, $Val extends VideoItem>
    implements $VideoItemCopyWith<$Res> {
  _$VideoItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? youtubeId = null,
    Object? videoUrl = null,
    Object? thumbnailUrl = null,
    Object? videoType = null,
    Object? category = null,
    Object? durationSeconds = null,
    Object? viewsCount = null,
    Object? isFeatured = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            youtubeId: null == youtubeId
                ? _value.youtubeId
                : youtubeId // ignore: cast_nullable_to_non_nullable
                      as String,
            videoUrl: null == videoUrl
                ? _value.videoUrl
                : videoUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailUrl: null == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            videoType: null == videoType
                ? _value.videoType
                : videoType // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            durationSeconds: null == durationSeconds
                ? _value.durationSeconds
                : durationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            viewsCount: null == viewsCount
                ? _value.viewsCount
                : viewsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VideoItemImplCopyWith<$Res>
    implements $VideoItemCopyWith<$Res> {
  factory _$$VideoItemImplCopyWith(
    _$VideoItemImpl value,
    $Res Function(_$VideoItemImpl) then,
  ) = __$$VideoItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String title,
    String description,
    @JsonKey(name: 'youtube_id') String youtubeId,
    @JsonKey(name: 'video_url') String videoUrl,
    @JsonKey(name: 'thumbnail_url') String thumbnailUrl,
    @JsonKey(name: 'video_type') String videoType,
    String category,
    @JsonKey(name: 'duration_seconds') int durationSeconds,
    @JsonKey(name: 'views_count') int viewsCount,
    @JsonKey(name: 'is_featured') bool isFeatured,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$VideoItemImplCopyWithImpl<$Res>
    extends _$VideoItemCopyWithImpl<$Res, _$VideoItemImpl>
    implements _$$VideoItemImplCopyWith<$Res> {
  __$$VideoItemImplCopyWithImpl(
    _$VideoItemImpl _value,
    $Res Function(_$VideoItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VideoItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? youtubeId = null,
    Object? videoUrl = null,
    Object? thumbnailUrl = null,
    Object? videoType = null,
    Object? category = null,
    Object? durationSeconds = null,
    Object? viewsCount = null,
    Object? isFeatured = null,
    Object? isActive = null,
  }) {
    return _then(
      _$VideoItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        youtubeId: null == youtubeId
            ? _value.youtubeId
            : youtubeId // ignore: cast_nullable_to_non_nullable
                  as String,
        videoUrl: null == videoUrl
            ? _value.videoUrl
            : videoUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        thumbnailUrl: null == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        videoType: null == videoType
            ? _value.videoType
            : videoType // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        durationSeconds: null == durationSeconds
            ? _value.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        viewsCount: null == viewsCount
            ? _value.viewsCount
            : viewsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoItemImpl implements _VideoItem {
  const _$VideoItemImpl({
    this.id,
    required this.title,
    this.description = '',
    @JsonKey(name: 'youtube_id') this.youtubeId = '',
    @JsonKey(name: 'video_url') this.videoUrl = '',
    @JsonKey(name: 'thumbnail_url') this.thumbnailUrl = '',
    @JsonKey(name: 'video_type') this.videoType = 'outro',
    this.category = 'geral',
    @JsonKey(name: 'duration_seconds') this.durationSeconds = 0,
    @JsonKey(name: 'views_count') this.viewsCount = 0,
    @JsonKey(name: 'is_featured') this.isFeatured = false,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$VideoItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoItemImplFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(name: 'youtube_id')
  final String youtubeId;
  @override
  @JsonKey(name: 'video_url')
  final String videoUrl;
  @override
  @JsonKey(name: 'thumbnail_url')
  final String thumbnailUrl;
  @override
  @JsonKey(name: 'video_type')
  final String videoType;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey(name: 'duration_seconds')
  final int durationSeconds;
  @override
  @JsonKey(name: 'views_count')
  final int viewsCount;
  @override
  @JsonKey(name: 'is_featured')
  final bool isFeatured;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'VideoItem(id: $id, title: $title, description: $description, youtubeId: $youtubeId, videoUrl: $videoUrl, thumbnailUrl: $thumbnailUrl, videoType: $videoType, category: $category, durationSeconds: $durationSeconds, viewsCount: $viewsCount, isFeatured: $isFeatured, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.youtubeId, youtubeId) ||
                other.youtubeId == youtubeId) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.videoType, videoType) ||
                other.videoType == videoType) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.viewsCount, viewsCount) ||
                other.viewsCount == viewsCount) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    youtubeId,
    videoUrl,
    thumbnailUrl,
    videoType,
    category,
    durationSeconds,
    viewsCount,
    isFeatured,
    isActive,
  );

  /// Create a copy of VideoItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoItemImplCopyWith<_$VideoItemImpl> get copyWith =>
      __$$VideoItemImplCopyWithImpl<_$VideoItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoItemImplToJson(this);
  }
}

abstract class _VideoItem implements VideoItem {
  const factory _VideoItem({
    final String? id,
    required final String title,
    final String description,
    @JsonKey(name: 'youtube_id') final String youtubeId,
    @JsonKey(name: 'video_url') final String videoUrl,
    @JsonKey(name: 'thumbnail_url') final String thumbnailUrl,
    @JsonKey(name: 'video_type') final String videoType,
    final String category,
    @JsonKey(name: 'duration_seconds') final int durationSeconds,
    @JsonKey(name: 'views_count') final int viewsCount,
    @JsonKey(name: 'is_featured') final bool isFeatured,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$VideoItemImpl;

  factory _VideoItem.fromJson(Map<String, dynamic> json) =
      _$VideoItemImpl.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'youtube_id')
  String get youtubeId;
  @override
  @JsonKey(name: 'video_url')
  String get videoUrl;
  @override
  @JsonKey(name: 'thumbnail_url')
  String get thumbnailUrl;
  @override
  @JsonKey(name: 'video_type')
  String get videoType;
  @override
  String get category;
  @override
  @JsonKey(name: 'duration_seconds')
  int get durationSeconds;
  @override
  @JsonKey(name: 'views_count')
  int get viewsCount;
  @override
  @JsonKey(name: 'is_featured')
  bool get isFeatured;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of VideoItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoItemImplCopyWith<_$VideoItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VolunteerRequest _$VolunteerRequestFromJson(Map<String, dynamic> json) {
  return _VolunteerRequest.fromJson(json);
}

/// @nodoc
mixin _$VolunteerRequest {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get whatsapp => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get neighborhood => throw _privateConstructorUsedError;
  List<String> get availability => throw _privateConstructorUsedError;
  List<String> get areas => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this VolunteerRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VolunteerRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VolunteerRequestCopyWith<VolunteerRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VolunteerRequestCopyWith<$Res> {
  factory $VolunteerRequestCopyWith(
    VolunteerRequest value,
    $Res Function(VolunteerRequest) then,
  ) = _$VolunteerRequestCopyWithImpl<$Res, VolunteerRequest>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'full_name') String fullName,
    String email,
    String phone,
    String whatsapp,
    String city,
    String neighborhood,
    List<String> availability,
    List<String> areas,
    String message,
    String status,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$VolunteerRequestCopyWithImpl<$Res, $Val extends VolunteerRequest>
    implements $VolunteerRequestCopyWith<$Res> {
  _$VolunteerRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VolunteerRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = null,
    Object? email = null,
    Object? phone = null,
    Object? whatsapp = null,
    Object? city = null,
    Object? neighborhood = null,
    Object? availability = null,
    Object? areas = null,
    Object? message = null,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            whatsapp: null == whatsapp
                ? _value.whatsapp
                : whatsapp // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            neighborhood: null == neighborhood
                ? _value.neighborhood
                : neighborhood // ignore: cast_nullable_to_non_nullable
                      as String,
            availability: null == availability
                ? _value.availability
                : availability // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            areas: null == areas
                ? _value.areas
                : areas // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VolunteerRequestImplCopyWith<$Res>
    implements $VolunteerRequestCopyWith<$Res> {
  factory _$$VolunteerRequestImplCopyWith(
    _$VolunteerRequestImpl value,
    $Res Function(_$VolunteerRequestImpl) then,
  ) = __$$VolunteerRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'full_name') String fullName,
    String email,
    String phone,
    String whatsapp,
    String city,
    String neighborhood,
    List<String> availability,
    List<String> areas,
    String message,
    String status,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$VolunteerRequestImplCopyWithImpl<$Res>
    extends _$VolunteerRequestCopyWithImpl<$Res, _$VolunteerRequestImpl>
    implements _$$VolunteerRequestImplCopyWith<$Res> {
  __$$VolunteerRequestImplCopyWithImpl(
    _$VolunteerRequestImpl _value,
    $Res Function(_$VolunteerRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VolunteerRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = null,
    Object? email = null,
    Object? phone = null,
    Object? whatsapp = null,
    Object? city = null,
    Object? neighborhood = null,
    Object? availability = null,
    Object? areas = null,
    Object? message = null,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$VolunteerRequestImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        whatsapp: null == whatsapp
            ? _value.whatsapp
            : whatsapp // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        neighborhood: null == neighborhood
            ? _value.neighborhood
            : neighborhood // ignore: cast_nullable_to_non_nullable
                  as String,
        availability: null == availability
            ? _value._availability
            : availability // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        areas: null == areas
            ? _value._areas
            : areas // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VolunteerRequestImpl implements _VolunteerRequest {
  const _$VolunteerRequestImpl({
    this.id,
    @JsonKey(name: 'full_name') required this.fullName,
    this.email = '',
    this.phone = '',
    this.whatsapp = '',
    this.city = '',
    this.neighborhood = '',
    final List<String> availability = const [],
    final List<String> areas = const [],
    this.message = '',
    this.status = 'pendente',
    @JsonKey(name: 'created_at') this.createdAt,
  }) : _availability = availability,
       _areas = areas;

  factory _$VolunteerRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$VolunteerRequestImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey()
  final String whatsapp;
  @override
  @JsonKey()
  final String city;
  @override
  @JsonKey()
  final String neighborhood;
  final List<String> _availability;
  @override
  @JsonKey()
  List<String> get availability {
    if (_availability is EqualUnmodifiableListView) return _availability;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availability);
  }

  final List<String> _areas;
  @override
  @JsonKey()
  List<String> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'VolunteerRequest(id: $id, fullName: $fullName, email: $email, phone: $phone, whatsapp: $whatsapp, city: $city, neighborhood: $neighborhood, availability: $availability, areas: $areas, message: $message, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VolunteerRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.whatsapp, whatsapp) ||
                other.whatsapp == whatsapp) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.neighborhood, neighborhood) ||
                other.neighborhood == neighborhood) &&
            const DeepCollectionEquality().equals(
              other._availability,
              _availability,
            ) &&
            const DeepCollectionEquality().equals(other._areas, _areas) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fullName,
    email,
    phone,
    whatsapp,
    city,
    neighborhood,
    const DeepCollectionEquality().hash(_availability),
    const DeepCollectionEquality().hash(_areas),
    message,
    status,
    createdAt,
  );

  /// Create a copy of VolunteerRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VolunteerRequestImplCopyWith<_$VolunteerRequestImpl> get copyWith =>
      __$$VolunteerRequestImplCopyWithImpl<_$VolunteerRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$VolunteerRequestImplToJson(this);
  }
}

abstract class _VolunteerRequest implements VolunteerRequest {
  const factory _VolunteerRequest({
    final String? id,
    @JsonKey(name: 'full_name') required final String fullName,
    final String email,
    final String phone,
    final String whatsapp,
    final String city,
    final String neighborhood,
    final List<String> availability,
    final List<String> areas,
    final String message,
    final String status,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$VolunteerRequestImpl;

  factory _VolunteerRequest.fromJson(Map<String, dynamic> json) =
      _$VolunteerRequestImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String get email;
  @override
  String get phone;
  @override
  String get whatsapp;
  @override
  String get city;
  @override
  String get neighborhood;
  @override
  List<String> get availability;
  @override
  List<String> get areas;
  @override
  String get message;
  @override
  String get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of VolunteerRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VolunteerRequestImplCopyWith<_$VolunteerRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageItem _$MessageItemFromJson(Map<String, dynamic> json) {
  return _MessageItem.fromJson(json);
}

/// @nodoc
mixin _$MessageItem {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_id')
  String get deviceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversation_id')
  String get conversationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_name')
  String get senderName => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_email')
  String get senderEmail => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<String> get attachments => throw _privateConstructorUsedError;
  String get channel => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_id')
  String? get parentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_admin_reply')
  bool get isAdminReply => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_read')
  bool get isRead => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this MessageItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageItemCopyWith<MessageItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageItemCopyWith<$Res> {
  factory $MessageItemCopyWith(
    MessageItem value,
    $Res Function(MessageItem) then,
  ) = _$MessageItemCopyWithImpl<$Res, MessageItem>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'device_id') String deviceId,
    @JsonKey(name: 'conversation_id') String conversationId,
    @JsonKey(name: 'sender_name') String senderName,
    @JsonKey(name: 'sender_email') String senderEmail,
    String subject,
    String category,
    String message,
    List<String> attachments,
    String channel,
    @JsonKey(name: 'parent_id') String? parentId,
    @JsonKey(name: 'is_admin_reply') bool isAdminReply,
    String status,
    @JsonKey(name: 'is_read') bool isRead,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$MessageItemCopyWithImpl<$Res, $Val extends MessageItem>
    implements $MessageItemCopyWith<$Res> {
  _$MessageItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? deviceId = null,
    Object? conversationId = null,
    Object? senderName = null,
    Object? senderEmail = null,
    Object? subject = null,
    Object? category = null,
    Object? message = null,
    Object? attachments = null,
    Object? channel = null,
    Object? parentId = freezed,
    Object? isAdminReply = null,
    Object? status = null,
    Object? isRead = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            deviceId: null == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                      as String,
            conversationId: null == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderName: null == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                      as String,
            senderEmail: null == senderEmail
                ? _value.senderEmail
                : senderEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            attachments: null == attachments
                ? _value.attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            channel: null == channel
                ? _value.channel
                : channel // ignore: cast_nullable_to_non_nullable
                      as String,
            parentId: freezed == parentId
                ? _value.parentId
                : parentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            isAdminReply: null == isAdminReply
                ? _value.isAdminReply
                : isAdminReply // ignore: cast_nullable_to_non_nullable
                      as bool,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessageItemImplCopyWith<$Res>
    implements $MessageItemCopyWith<$Res> {
  factory _$$MessageItemImplCopyWith(
    _$MessageItemImpl value,
    $Res Function(_$MessageItemImpl) then,
  ) = __$$MessageItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'device_id') String deviceId,
    @JsonKey(name: 'conversation_id') String conversationId,
    @JsonKey(name: 'sender_name') String senderName,
    @JsonKey(name: 'sender_email') String senderEmail,
    String subject,
    String category,
    String message,
    List<String> attachments,
    String channel,
    @JsonKey(name: 'parent_id') String? parentId,
    @JsonKey(name: 'is_admin_reply') bool isAdminReply,
    String status,
    @JsonKey(name: 'is_read') bool isRead,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$MessageItemImplCopyWithImpl<$Res>
    extends _$MessageItemCopyWithImpl<$Res, _$MessageItemImpl>
    implements _$$MessageItemImplCopyWith<$Res> {
  __$$MessageItemImplCopyWithImpl(
    _$MessageItemImpl _value,
    $Res Function(_$MessageItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessageItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? deviceId = null,
    Object? conversationId = null,
    Object? senderName = null,
    Object? senderEmail = null,
    Object? subject = null,
    Object? category = null,
    Object? message = null,
    Object? attachments = null,
    Object? channel = null,
    Object? parentId = freezed,
    Object? isAdminReply = null,
    Object? status = null,
    Object? isRead = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$MessageItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        deviceId: null == deviceId
            ? _value.deviceId
            : deviceId // ignore: cast_nullable_to_non_nullable
                  as String,
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderName: null == senderName
            ? _value.senderName
            : senderName // ignore: cast_nullable_to_non_nullable
                  as String,
        senderEmail: null == senderEmail
            ? _value.senderEmail
            : senderEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        attachments: null == attachments
            ? _value._attachments
            : attachments // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        channel: null == channel
            ? _value.channel
            : channel // ignore: cast_nullable_to_non_nullable
                  as String,
        parentId: freezed == parentId
            ? _value.parentId
            : parentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isAdminReply: null == isAdminReply
            ? _value.isAdminReply
            : isAdminReply // ignore: cast_nullable_to_non_nullable
                  as bool,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageItemImpl implements _MessageItem {
  const _$MessageItemImpl({
    this.id,
    @JsonKey(name: 'device_id') this.deviceId = '',
    @JsonKey(name: 'conversation_id') this.conversationId = '',
    @JsonKey(name: 'sender_name') this.senderName = '',
    @JsonKey(name: 'sender_email') this.senderEmail = '',
    this.subject = '',
    this.category = '',
    required this.message,
    final List<String> attachments = const [],
    this.channel = 'form',
    @JsonKey(name: 'parent_id') this.parentId,
    @JsonKey(name: 'is_admin_reply') this.isAdminReply = false,
    this.status = 'novo',
    @JsonKey(name: 'is_read') this.isRead = false,
    @JsonKey(name: 'created_at') this.createdAt,
  }) : _attachments = attachments;

  factory _$MessageItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageItemImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'device_id')
  final String deviceId;
  @override
  @JsonKey(name: 'conversation_id')
  final String conversationId;
  @override
  @JsonKey(name: 'sender_name')
  final String senderName;
  @override
  @JsonKey(name: 'sender_email')
  final String senderEmail;
  @override
  @JsonKey()
  final String subject;
  @override
  @JsonKey()
  final String category;
  @override
  final String message;
  final List<String> _attachments;
  @override
  @JsonKey()
  List<String> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  @JsonKey()
  final String channel;
  @override
  @JsonKey(name: 'parent_id')
  final String? parentId;
  @override
  @JsonKey(name: 'is_admin_reply')
  final bool isAdminReply;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'is_read')
  final bool isRead;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'MessageItem(id: $id, deviceId: $deviceId, conversationId: $conversationId, senderName: $senderName, senderEmail: $senderEmail, subject: $subject, category: $category, message: $message, attachments: $attachments, channel: $channel, parentId: $parentId, isAdminReply: $isAdminReply, status: $status, isRead: $isRead, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderEmail, senderEmail) ||
                other.senderEmail == senderEmail) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.isAdminReply, isAdminReply) ||
                other.isAdminReply == isAdminReply) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    deviceId,
    conversationId,
    senderName,
    senderEmail,
    subject,
    category,
    message,
    const DeepCollectionEquality().hash(_attachments),
    channel,
    parentId,
    isAdminReply,
    status,
    isRead,
    createdAt,
  );

  /// Create a copy of MessageItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageItemImplCopyWith<_$MessageItemImpl> get copyWith =>
      __$$MessageItemImplCopyWithImpl<_$MessageItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageItemImplToJson(this);
  }
}

abstract class _MessageItem implements MessageItem {
  const factory _MessageItem({
    final String? id,
    @JsonKey(name: 'device_id') final String deviceId,
    @JsonKey(name: 'conversation_id') final String conversationId,
    @JsonKey(name: 'sender_name') final String senderName,
    @JsonKey(name: 'sender_email') final String senderEmail,
    final String subject,
    final String category,
    required final String message,
    final List<String> attachments,
    final String channel,
    @JsonKey(name: 'parent_id') final String? parentId,
    @JsonKey(name: 'is_admin_reply') final bool isAdminReply,
    final String status,
    @JsonKey(name: 'is_read') final bool isRead,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$MessageItemImpl;

  factory _MessageItem.fromJson(Map<String, dynamic> json) =
      _$MessageItemImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'device_id')
  String get deviceId;
  @override
  @JsonKey(name: 'conversation_id')
  String get conversationId;
  @override
  @JsonKey(name: 'sender_name')
  String get senderName;
  @override
  @JsonKey(name: 'sender_email')
  String get senderEmail;
  @override
  String get subject;
  @override
  String get category;
  @override
  String get message;
  @override
  List<String> get attachments;
  @override
  String get channel;
  @override
  @JsonKey(name: 'parent_id')
  String? get parentId;
  @override
  @JsonKey(name: 'is_admin_reply')
  bool get isAdminReply;
  @override
  String get status;
  @override
  @JsonKey(name: 'is_read')
  bool get isRead;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of MessageItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageItemImplCopyWith<_$MessageItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReportItem _$ReportItemFromJson(Map<String, dynamic> json) {
  return _ReportItem.fromJson(json);
}

/// @nodoc
mixin _$ReportItem {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_id')
  String get deviceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin_note')
  String get adminNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ReportItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportItemCopyWith<ReportItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportItemCopyWith<$Res> {
  factory $ReportItemCopyWith(
    ReportItem value,
    $Res Function(ReportItem) then,
  ) = _$ReportItemCopyWithImpl<$Res, ReportItem>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'device_id') String deviceId,
    @JsonKey(name: 'full_name') String fullName,
    String city,
    String category,
    String description,
    @JsonKey(name: 'image_url') String imageUrl,
    double? latitude,
    double? longitude,
    String status,
    @JsonKey(name: 'admin_note') String adminNote,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$ReportItemCopyWithImpl<$Res, $Val extends ReportItem>
    implements $ReportItemCopyWith<$Res> {
  _$ReportItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? deviceId = null,
    Object? fullName = null,
    Object? city = null,
    Object? category = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? status = null,
    Object? adminNote = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            deviceId: null == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            adminNote: null == adminNote
                ? _value.adminNote
                : adminNote // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReportItemImplCopyWith<$Res>
    implements $ReportItemCopyWith<$Res> {
  factory _$$ReportItemImplCopyWith(
    _$ReportItemImpl value,
    $Res Function(_$ReportItemImpl) then,
  ) = __$$ReportItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'device_id') String deviceId,
    @JsonKey(name: 'full_name') String fullName,
    String city,
    String category,
    String description,
    @JsonKey(name: 'image_url') String imageUrl,
    double? latitude,
    double? longitude,
    String status,
    @JsonKey(name: 'admin_note') String adminNote,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$ReportItemImplCopyWithImpl<$Res>
    extends _$ReportItemCopyWithImpl<$Res, _$ReportItemImpl>
    implements _$$ReportItemImplCopyWith<$Res> {
  __$$ReportItemImplCopyWithImpl(
    _$ReportItemImpl _value,
    $Res Function(_$ReportItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? deviceId = null,
    Object? fullName = null,
    Object? city = null,
    Object? category = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? status = null,
    Object? adminNote = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$ReportItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        deviceId: null == deviceId
            ? _value.deviceId
            : deviceId // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        adminNote: null == adminNote
            ? _value.adminNote
            : adminNote // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportItemImpl extends _ReportItem {
  const _$ReportItemImpl({
    this.id,
    @JsonKey(name: 'device_id') this.deviceId = '',
    @JsonKey(name: 'full_name') this.fullName = '',
    this.city = '',
    this.category = 'outro',
    required this.description,
    @JsonKey(name: 'image_url') this.imageUrl = '',
    this.latitude,
    this.longitude,
    this.status = 'pendente',
    @JsonKey(name: 'admin_note') this.adminNote = '',
    @JsonKey(name: 'created_at') this.createdAt,
  }) : super._();

  factory _$ReportItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportItemImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'device_id')
  final String deviceId;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey()
  final String city;
  @override
  @JsonKey()
  final String category;
  @override
  final String description;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'admin_note')
  final String adminNote;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ReportItem(id: $id, deviceId: $deviceId, fullName: $fullName, city: $city, category: $category, description: $description, imageUrl: $imageUrl, latitude: $latitude, longitude: $longitude, status: $status, adminNote: $adminNote, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.adminNote, adminNote) ||
                other.adminNote == adminNote) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    deviceId,
    fullName,
    city,
    category,
    description,
    imageUrl,
    latitude,
    longitude,
    status,
    adminNote,
    createdAt,
  );

  /// Create a copy of ReportItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportItemImplCopyWith<_$ReportItemImpl> get copyWith =>
      __$$ReportItemImplCopyWithImpl<_$ReportItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportItemImplToJson(this);
  }
}

abstract class _ReportItem extends ReportItem {
  const factory _ReportItem({
    final String? id,
    @JsonKey(name: 'device_id') final String deviceId,
    @JsonKey(name: 'full_name') final String fullName,
    final String city,
    final String category,
    required final String description,
    @JsonKey(name: 'image_url') final String imageUrl,
    final double? latitude,
    final double? longitude,
    final String status,
    @JsonKey(name: 'admin_note') final String adminNote,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$ReportItemImpl;
  const _ReportItem._() : super._();

  factory _ReportItem.fromJson(Map<String, dynamic> json) =
      _$ReportItemImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'device_id')
  String get deviceId;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String get city;
  @override
  String get category;
  @override
  String get description;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String get status;
  @override
  @JsonKey(name: 'admin_note')
  String get adminNote;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of ReportItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportItemImplCopyWith<_$ReportItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DownloadItem _$DownloadItemFromJson(Map<String, dynamic> json) {
  return _DownloadItem.fromJson(json);
}

/// @nodoc
mixin _$DownloadItem {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_url')
  String get fileUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_type')
  String get fileType => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_size')
  int get fileSize => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this DownloadItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DownloadItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DownloadItemCopyWith<DownloadItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DownloadItemCopyWith<$Res> {
  factory $DownloadItemCopyWith(
    DownloadItem value,
    $Res Function(DownloadItem) then,
  ) = _$DownloadItemCopyWithImpl<$Res, DownloadItem>;
  @useResult
  $Res call({
    String? id,
    String title,
    String description,
    @JsonKey(name: 'file_url') String fileUrl,
    @JsonKey(name: 'file_type') String fileType,
    @JsonKey(name: 'file_size') int fileSize,
    String icon,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$DownloadItemCopyWithImpl<$Res, $Val extends DownloadItem>
    implements $DownloadItemCopyWith<$Res> {
  _$DownloadItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DownloadItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? fileUrl = null,
    Object? fileType = null,
    Object? fileSize = null,
    Object? icon = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            fileUrl: null == fileUrl
                ? _value.fileUrl
                : fileUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            fileType: null == fileType
                ? _value.fileType
                : fileType // ignore: cast_nullable_to_non_nullable
                      as String,
            fileSize: null == fileSize
                ? _value.fileSize
                : fileSize // ignore: cast_nullable_to_non_nullable
                      as int,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DownloadItemImplCopyWith<$Res>
    implements $DownloadItemCopyWith<$Res> {
  factory _$$DownloadItemImplCopyWith(
    _$DownloadItemImpl value,
    $Res Function(_$DownloadItemImpl) then,
  ) = __$$DownloadItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String title,
    String description,
    @JsonKey(name: 'file_url') String fileUrl,
    @JsonKey(name: 'file_type') String fileType,
    @JsonKey(name: 'file_size') int fileSize,
    String icon,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$DownloadItemImplCopyWithImpl<$Res>
    extends _$DownloadItemCopyWithImpl<$Res, _$DownloadItemImpl>
    implements _$$DownloadItemImplCopyWith<$Res> {
  __$$DownloadItemImplCopyWithImpl(
    _$DownloadItemImpl _value,
    $Res Function(_$DownloadItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DownloadItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? fileUrl = null,
    Object? fileType = null,
    Object? fileSize = null,
    Object? icon = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _$DownloadItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        fileUrl: null == fileUrl
            ? _value.fileUrl
            : fileUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        fileType: null == fileType
            ? _value.fileType
            : fileType // ignore: cast_nullable_to_non_nullable
                  as String,
        fileSize: null == fileSize
            ? _value.fileSize
            : fileSize // ignore: cast_nullable_to_non_nullable
                  as int,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DownloadItemImpl implements _DownloadItem {
  const _$DownloadItemImpl({
    this.id,
    required this.title,
    this.description = '',
    @JsonKey(name: 'file_url') this.fileUrl = '',
    @JsonKey(name: 'file_type') this.fileType = 'pdf',
    @JsonKey(name: 'file_size') this.fileSize = 0,
    this.icon = 'download_rounded',
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$DownloadItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DownloadItemImplFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(name: 'file_url')
  final String fileUrl;
  @override
  @JsonKey(name: 'file_type')
  final String fileType;
  @override
  @JsonKey(name: 'file_size')
  final int fileSize;
  @override
  @JsonKey()
  final String icon;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'DownloadItem(id: $id, title: $title, description: $description, fileUrl: $fileUrl, fileType: $fileType, fileSize: $fileSize, icon: $icon, sortOrder: $sortOrder, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DownloadItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.fileType, fileType) ||
                other.fileType == fileType) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    fileUrl,
    fileType,
    fileSize,
    icon,
    sortOrder,
    isActive,
  );

  /// Create a copy of DownloadItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DownloadItemImplCopyWith<_$DownloadItemImpl> get copyWith =>
      __$$DownloadItemImplCopyWithImpl<_$DownloadItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DownloadItemImplToJson(this);
  }
}

abstract class _DownloadItem implements DownloadItem {
  const factory _DownloadItem({
    final String? id,
    required final String title,
    final String description,
    @JsonKey(name: 'file_url') final String fileUrl,
    @JsonKey(name: 'file_type') final String fileType,
    @JsonKey(name: 'file_size') final int fileSize,
    final String icon,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$DownloadItemImpl;

  factory _DownloadItem.fromJson(Map<String, dynamic> json) =
      _$DownloadItemImpl.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'file_url')
  String get fileUrl;
  @override
  @JsonKey(name: 'file_type')
  String get fileType;
  @override
  @JsonKey(name: 'file_size')
  int get fileSize;
  @override
  String get icon;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of DownloadItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DownloadItemImplCopyWith<_$DownloadItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SocialLink _$SocialLinkFromJson(Map<String, dynamic> json) {
  return _SocialLink.fromJson(json);
}

/// @nodoc
mixin _$SocialLink {
  String? get id => throw _privateConstructorUsedError;
  String get platform => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this SocialLink to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SocialLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SocialLinkCopyWith<SocialLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialLinkCopyWith<$Res> {
  factory $SocialLinkCopyWith(
    SocialLink value,
    $Res Function(SocialLink) then,
  ) = _$SocialLinkCopyWithImpl<$Res, SocialLink>;
  @useResult
  $Res call({
    String? id,
    String platform,
    String url,
    String username,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$SocialLinkCopyWithImpl<$Res, $Val extends SocialLink>
    implements $SocialLinkCopyWith<$Res> {
  _$SocialLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SocialLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? platform = null,
    Object? url = null,
    Object? username = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            platform: null == platform
                ? _value.platform
                : platform // ignore: cast_nullable_to_non_nullable
                      as String,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SocialLinkImplCopyWith<$Res>
    implements $SocialLinkCopyWith<$Res> {
  factory _$$SocialLinkImplCopyWith(
    _$SocialLinkImpl value,
    $Res Function(_$SocialLinkImpl) then,
  ) = __$$SocialLinkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String platform,
    String url,
    String username,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$SocialLinkImplCopyWithImpl<$Res>
    extends _$SocialLinkCopyWithImpl<$Res, _$SocialLinkImpl>
    implements _$$SocialLinkImplCopyWith<$Res> {
  __$$SocialLinkImplCopyWithImpl(
    _$SocialLinkImpl _value,
    $Res Function(_$SocialLinkImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SocialLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? platform = null,
    Object? url = null,
    Object? username = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _$SocialLinkImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        platform: null == platform
            ? _value.platform
            : platform // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SocialLinkImpl implements _SocialLink {
  const _$SocialLinkImpl({
    this.id,
    required this.platform,
    required this.url,
    this.username = '',
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$SocialLinkImpl.fromJson(Map<String, dynamic> json) =>
      _$$SocialLinkImplFromJson(json);

  @override
  final String? id;
  @override
  final String platform;
  @override
  final String url;
  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'SocialLink(id: $id, platform: $platform, url: $url, username: $username, sortOrder: $sortOrder, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialLinkImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    platform,
    url,
    username,
    sortOrder,
    isActive,
  );

  /// Create a copy of SocialLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialLinkImplCopyWith<_$SocialLinkImpl> get copyWith =>
      __$$SocialLinkImplCopyWithImpl<_$SocialLinkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SocialLinkImplToJson(this);
  }
}

abstract class _SocialLink implements SocialLink {
  const factory _SocialLink({
    final String? id,
    required final String platform,
    required final String url,
    final String username,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$SocialLinkImpl;

  factory _SocialLink.fromJson(Map<String, dynamic> json) =
      _$SocialLinkImpl.fromJson;

  @override
  String? get id;
  @override
  String get platform;
  @override
  String get url;
  @override
  String get username;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of SocialLink
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SocialLinkImplCopyWith<_$SocialLinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CampaignNumber _$CampaignNumberFromJson(Map<String, dynamic> json) {
  return _CampaignNumber.fromJson(json);
}

/// @nodoc
mixin _$CampaignNumber {
  String? get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String get trend => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_positive')
  bool get isPositive => throw _privateConstructorUsedError;
  String get tone => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this CampaignNumber to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CampaignNumber
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CampaignNumberCopyWith<CampaignNumber> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampaignNumberCopyWith<$Res> {
  factory $CampaignNumberCopyWith(
    CampaignNumber value,
    $Res Function(CampaignNumber) then,
  ) = _$CampaignNumberCopyWithImpl<$Res, CampaignNumber>;
  @useResult
  $Res call({
    String? id,
    String label,
    String value,
    String trend,
    @JsonKey(name: 'is_positive') bool isPositive,
    String tone,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$CampaignNumberCopyWithImpl<$Res, $Val extends CampaignNumber>
    implements $CampaignNumberCopyWith<$Res> {
  _$CampaignNumberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CampaignNumber
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? label = null,
    Object? value = null,
    Object? trend = null,
    Object? isPositive = null,
    Object? tone = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as String,
            trend: null == trend
                ? _value.trend
                : trend // ignore: cast_nullable_to_non_nullable
                      as String,
            isPositive: null == isPositive
                ? _value.isPositive
                : isPositive // ignore: cast_nullable_to_non_nullable
                      as bool,
            tone: null == tone
                ? _value.tone
                : tone // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CampaignNumberImplCopyWith<$Res>
    implements $CampaignNumberCopyWith<$Res> {
  factory _$$CampaignNumberImplCopyWith(
    _$CampaignNumberImpl value,
    $Res Function(_$CampaignNumberImpl) then,
  ) = __$$CampaignNumberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String label,
    String value,
    String trend,
    @JsonKey(name: 'is_positive') bool isPositive,
    String tone,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$CampaignNumberImplCopyWithImpl<$Res>
    extends _$CampaignNumberCopyWithImpl<$Res, _$CampaignNumberImpl>
    implements _$$CampaignNumberImplCopyWith<$Res> {
  __$$CampaignNumberImplCopyWithImpl(
    _$CampaignNumberImpl _value,
    $Res Function(_$CampaignNumberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CampaignNumber
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? label = null,
    Object? value = null,
    Object? trend = null,
    Object? isPositive = null,
    Object? tone = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _$CampaignNumberImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
        trend: null == trend
            ? _value.trend
            : trend // ignore: cast_nullable_to_non_nullable
                  as String,
        isPositive: null == isPositive
            ? _value.isPositive
            : isPositive // ignore: cast_nullable_to_non_nullable
                  as bool,
        tone: null == tone
            ? _value.tone
            : tone // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CampaignNumberImpl implements _CampaignNumber {
  const _$CampaignNumberImpl({
    this.id,
    required this.label,
    required this.value,
    this.trend = '',
    @JsonKey(name: 'is_positive') this.isPositive = true,
    this.tone = 'primary',
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$CampaignNumberImpl.fromJson(Map<String, dynamic> json) =>
      _$$CampaignNumberImplFromJson(json);

  @override
  final String? id;
  @override
  final String label;
  @override
  final String value;
  @override
  @JsonKey()
  final String trend;
  @override
  @JsonKey(name: 'is_positive')
  final bool isPositive;
  @override
  @JsonKey()
  final String tone;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'CampaignNumber(id: $id, label: $label, value: $value, trend: $trend, isPositive: $isPositive, tone: $tone, sortOrder: $sortOrder, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampaignNumberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.trend, trend) || other.trend == trend) &&
            (identical(other.isPositive, isPositive) ||
                other.isPositive == isPositive) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    label,
    value,
    trend,
    isPositive,
    tone,
    sortOrder,
    isActive,
  );

  /// Create a copy of CampaignNumber
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CampaignNumberImplCopyWith<_$CampaignNumberImpl> get copyWith =>
      __$$CampaignNumberImplCopyWithImpl<_$CampaignNumberImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CampaignNumberImplToJson(this);
  }
}

abstract class _CampaignNumber implements CampaignNumber {
  const factory _CampaignNumber({
    final String? id,
    required final String label,
    required final String value,
    final String trend,
    @JsonKey(name: 'is_positive') final bool isPositive,
    final String tone,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$CampaignNumberImpl;

  factory _CampaignNumber.fromJson(Map<String, dynamic> json) =
      _$CampaignNumberImpl.fromJson;

  @override
  String? get id;
  @override
  String get label;
  @override
  String get value;
  @override
  String get trend;
  @override
  @JsonKey(name: 'is_positive')
  bool get isPositive;
  @override
  String get tone;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of CampaignNumber
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CampaignNumberImplCopyWith<_$CampaignNumberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BannerHome _$BannerHomeFromJson(Map<String, dynamic> json) {
  return _BannerHome.fromJson(json);
}

/// @nodoc
mixin _$BannerHome {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get badge => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'cta_label')
  String get ctaLabel => throw _privateConstructorUsedError;
  @JsonKey(name: 'cta_url')
  String get ctaUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this BannerHome to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BannerHome
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BannerHomeCopyWith<BannerHome> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BannerHomeCopyWith<$Res> {
  factory $BannerHomeCopyWith(
    BannerHome value,
    $Res Function(BannerHome) then,
  ) = _$BannerHomeCopyWithImpl<$Res, BannerHome>;
  @useResult
  $Res call({
    String? id,
    String title,
    String subtitle,
    String badge,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'cta_label') String ctaLabel,
    @JsonKey(name: 'cta_url') String ctaUrl,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class _$BannerHomeCopyWithImpl<$Res, $Val extends BannerHome>
    implements $BannerHomeCopyWith<$Res> {
  _$BannerHomeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BannerHome
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? subtitle = null,
    Object? badge = null,
    Object? imageUrl = null,
    Object? ctaLabel = null,
    Object? ctaUrl = null,
    Object? isActive = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String,
            badge: null == badge
                ? _value.badge
                : badge // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            ctaLabel: null == ctaLabel
                ? _value.ctaLabel
                : ctaLabel // ignore: cast_nullable_to_non_nullable
                      as String,
            ctaUrl: null == ctaUrl
                ? _value.ctaUrl
                : ctaUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BannerHomeImplCopyWith<$Res>
    implements $BannerHomeCopyWith<$Res> {
  factory _$$BannerHomeImplCopyWith(
    _$BannerHomeImpl value,
    $Res Function(_$BannerHomeImpl) then,
  ) = __$$BannerHomeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String title,
    String subtitle,
    String badge,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'cta_label') String ctaLabel,
    @JsonKey(name: 'cta_url') String ctaUrl,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class __$$BannerHomeImplCopyWithImpl<$Res>
    extends _$BannerHomeCopyWithImpl<$Res, _$BannerHomeImpl>
    implements _$$BannerHomeImplCopyWith<$Res> {
  __$$BannerHomeImplCopyWithImpl(
    _$BannerHomeImpl _value,
    $Res Function(_$BannerHomeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BannerHome
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? subtitle = null,
    Object? badge = null,
    Object? imageUrl = null,
    Object? ctaLabel = null,
    Object? ctaUrl = null,
    Object? isActive = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _$BannerHomeImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String,
        badge: null == badge
            ? _value.badge
            : badge // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        ctaLabel: null == ctaLabel
            ? _value.ctaLabel
            : ctaLabel // ignore: cast_nullable_to_non_nullable
                  as String,
        ctaUrl: null == ctaUrl
            ? _value.ctaUrl
            : ctaUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BannerHomeImpl implements _BannerHome {
  const _$BannerHomeImpl({
    this.id,
    required this.title,
    this.subtitle = '',
    this.badge = '',
    @JsonKey(name: 'image_url') this.imageUrl = '',
    @JsonKey(name: 'cta_label') this.ctaLabel = '',
    @JsonKey(name: 'cta_url') this.ctaUrl = '',
    @JsonKey(name: 'is_active') this.isActive = true,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
  });

  factory _$BannerHomeImpl.fromJson(Map<String, dynamic> json) =>
      _$$BannerHomeImplFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  @JsonKey()
  final String subtitle;
  @override
  @JsonKey()
  final String badge;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey(name: 'cta_label')
  final String ctaLabel;
  @override
  @JsonKey(name: 'cta_url')
  final String ctaUrl;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;

  @override
  String toString() {
    return 'BannerHome(id: $id, title: $title, subtitle: $subtitle, badge: $badge, imageUrl: $imageUrl, ctaLabel: $ctaLabel, ctaUrl: $ctaUrl, isActive: $isActive, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BannerHomeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.badge, badge) || other.badge == badge) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.ctaLabel, ctaLabel) ||
                other.ctaLabel == ctaLabel) &&
            (identical(other.ctaUrl, ctaUrl) || other.ctaUrl == ctaUrl) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    subtitle,
    badge,
    imageUrl,
    ctaLabel,
    ctaUrl,
    isActive,
    sortOrder,
  );

  /// Create a copy of BannerHome
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BannerHomeImplCopyWith<_$BannerHomeImpl> get copyWith =>
      __$$BannerHomeImplCopyWithImpl<_$BannerHomeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BannerHomeImplToJson(this);
  }
}

abstract class _BannerHome implements BannerHome {
  const factory _BannerHome({
    final String? id,
    required final String title,
    final String subtitle,
    final String badge,
    @JsonKey(name: 'image_url') final String imageUrl,
    @JsonKey(name: 'cta_label') final String ctaLabel,
    @JsonKey(name: 'cta_url') final String ctaUrl,
    @JsonKey(name: 'is_active') final bool isActive,
    @JsonKey(name: 'sort_order') final int sortOrder,
  }) = _$BannerHomeImpl;

  factory _BannerHome.fromJson(Map<String, dynamic> json) =
      _$BannerHomeImpl.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get badge;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  @JsonKey(name: 'cta_label')
  String get ctaLabel;
  @override
  @JsonKey(name: 'cta_url')
  String get ctaUrl;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;

  /// Create a copy of BannerHome
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BannerHomeImplCopyWith<_$BannerHomeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamMember _$TeamMemberFromJson(Map<String, dynamic> json) {
  return _TeamMember.fromJson(json);
}

/// @nodoc
mixin _$TeamMember {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_url')
  String get photoUrl => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this TeamMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamMemberCopyWith<TeamMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamMemberCopyWith<$Res> {
  factory $TeamMemberCopyWith(
    TeamMember value,
    $Res Function(TeamMember) then,
  ) = _$TeamMemberCopyWithImpl<$Res, TeamMember>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'full_name') String fullName,
    String role,
    @JsonKey(name: 'photo_url') String photoUrl,
    String bio,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$TeamMemberCopyWithImpl<$Res, $Val extends TeamMember>
    implements $TeamMemberCopyWith<$Res> {
  _$TeamMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = null,
    Object? role = null,
    Object? photoUrl = null,
    Object? bio = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            photoUrl: null == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            bio: null == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TeamMemberImplCopyWith<$Res>
    implements $TeamMemberCopyWith<$Res> {
  factory _$$TeamMemberImplCopyWith(
    _$TeamMemberImpl value,
    $Res Function(_$TeamMemberImpl) then,
  ) = __$$TeamMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'full_name') String fullName,
    String role,
    @JsonKey(name: 'photo_url') String photoUrl,
    String bio,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$TeamMemberImplCopyWithImpl<$Res>
    extends _$TeamMemberCopyWithImpl<$Res, _$TeamMemberImpl>
    implements _$$TeamMemberImplCopyWith<$Res> {
  __$$TeamMemberImplCopyWithImpl(
    _$TeamMemberImpl _value,
    $Res Function(_$TeamMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TeamMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = null,
    Object? role = null,
    Object? photoUrl = null,
    Object? bio = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _$TeamMemberImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        photoUrl: null == photoUrl
            ? _value.photoUrl
            : photoUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        bio: null == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamMemberImpl implements _TeamMember {
  const _$TeamMemberImpl({
    this.id,
    @JsonKey(name: 'full_name') required this.fullName,
    this.role = '',
    @JsonKey(name: 'photo_url') this.photoUrl = '',
    this.bio = '',
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$TeamMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamMemberImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey()
  final String role;
  @override
  @JsonKey(name: 'photo_url')
  final String photoUrl;
  @override
  @JsonKey()
  final String bio;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'TeamMember(id: $id, fullName: $fullName, role: $role, photoUrl: $photoUrl, bio: $bio, sortOrder: $sortOrder, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fullName,
    role,
    photoUrl,
    bio,
    sortOrder,
    isActive,
  );

  /// Create a copy of TeamMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamMemberImplCopyWith<_$TeamMemberImpl> get copyWith =>
      __$$TeamMemberImplCopyWithImpl<_$TeamMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamMemberImplToJson(this);
  }
}

abstract class _TeamMember implements TeamMember {
  const factory _TeamMember({
    final String? id,
    @JsonKey(name: 'full_name') required final String fullName,
    final String role,
    @JsonKey(name: 'photo_url') final String photoUrl,
    final String bio,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$TeamMemberImpl;

  factory _TeamMember.fromJson(Map<String, dynamic> json) =
      _$TeamMemberImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String get role;
  @override
  @JsonKey(name: 'photo_url')
  String get photoUrl;
  @override
  String get bio;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of TeamMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamMemberImplCopyWith<_$TeamMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Testimonial _$TestimonialFromJson(Map<String, dynamic> json) {
  return _Testimonial.fromJson(json);
}

/// @nodoc
mixin _$Testimonial {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_name')
  String get authorName => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_url')
  String get photoUrl => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this Testimonial to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Testimonial
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestimonialCopyWith<Testimonial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestimonialCopyWith<$Res> {
  factory $TestimonialCopyWith(
    Testimonial value,
    $Res Function(Testimonial) then,
  ) = _$TestimonialCopyWithImpl<$Res, Testimonial>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'author_name') String authorName,
    String city,
    String role,
    String content,
    @JsonKey(name: 'photo_url') String photoUrl,
    int rating,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$TestimonialCopyWithImpl<$Res, $Val extends Testimonial>
    implements $TestimonialCopyWith<$Res> {
  _$TestimonialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Testimonial
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? authorName = null,
    Object? city = null,
    Object? role = null,
    Object? content = null,
    Object? photoUrl = null,
    Object? rating = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            authorName: null == authorName
                ? _value.authorName
                : authorName // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            photoUrl: null == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as int,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TestimonialImplCopyWith<$Res>
    implements $TestimonialCopyWith<$Res> {
  factory _$$TestimonialImplCopyWith(
    _$TestimonialImpl value,
    $Res Function(_$TestimonialImpl) then,
  ) = __$$TestimonialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'author_name') String authorName,
    String city,
    String role,
    String content,
    @JsonKey(name: 'photo_url') String photoUrl,
    int rating,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$TestimonialImplCopyWithImpl<$Res>
    extends _$TestimonialCopyWithImpl<$Res, _$TestimonialImpl>
    implements _$$TestimonialImplCopyWith<$Res> {
  __$$TestimonialImplCopyWithImpl(
    _$TestimonialImpl _value,
    $Res Function(_$TestimonialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Testimonial
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? authorName = null,
    Object? city = null,
    Object? role = null,
    Object? content = null,
    Object? photoUrl = null,
    Object? rating = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _$TestimonialImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        authorName: null == authorName
            ? _value.authorName
            : authorName // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        photoUrl: null == photoUrl
            ? _value.photoUrl
            : photoUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as int,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TestimonialImpl implements _Testimonial {
  const _$TestimonialImpl({
    this.id,
    @JsonKey(name: 'author_name') required this.authorName,
    this.city = '',
    this.role = '',
    required this.content,
    @JsonKey(name: 'photo_url') this.photoUrl = '',
    this.rating = 5,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$TestimonialImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestimonialImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'author_name')
  final String authorName;
  @override
  @JsonKey()
  final String city;
  @override
  @JsonKey()
  final String role;
  @override
  final String content;
  @override
  @JsonKey(name: 'photo_url')
  final String photoUrl;
  @override
  @JsonKey()
  final int rating;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'Testimonial(id: $id, authorName: $authorName, city: $city, role: $role, content: $content, photoUrl: $photoUrl, rating: $rating, sortOrder: $sortOrder, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestimonialImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    authorName,
    city,
    role,
    content,
    photoUrl,
    rating,
    sortOrder,
    isActive,
  );

  /// Create a copy of Testimonial
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestimonialImplCopyWith<_$TestimonialImpl> get copyWith =>
      __$$TestimonialImplCopyWithImpl<_$TestimonialImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestimonialImplToJson(this);
  }
}

abstract class _Testimonial implements Testimonial {
  const factory _Testimonial({
    final String? id,
    @JsonKey(name: 'author_name') required final String authorName,
    final String city,
    final String role,
    required final String content,
    @JsonKey(name: 'photo_url') final String photoUrl,
    final int rating,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$TestimonialImpl;

  factory _Testimonial.fromJson(Map<String, dynamic> json) =
      _$TestimonialImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'author_name')
  String get authorName;
  @override
  String get city;
  @override
  String get role;
  @override
  String get content;
  @override
  @JsonKey(name: 'photo_url')
  String get photoUrl;
  @override
  int get rating;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of Testimonial
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestimonialImplCopyWith<_$TestimonialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FaqItem _$FaqItemFromJson(Map<String, dynamic> json) {
  return _FaqItem.fromJson(json);
}

/// @nodoc
mixin _$FaqItem {
  String? get id => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this FaqItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FaqItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FaqItemCopyWith<FaqItem> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaqItemCopyWith<$Res> {
  factory $FaqItemCopyWith(FaqItem value, $Res Function(FaqItem) then) =
      _$FaqItemCopyWithImpl<$Res, FaqItem>;
  @useResult
  $Res call({
    String? id,
    String question,
    String answer,
    String category,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$FaqItemCopyWithImpl<$Res, $Val extends FaqItem>
    implements $FaqItemCopyWith<$Res> {
  _$FaqItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FaqItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? question = null,
    Object? answer = null,
    Object? category = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String,
            answer: null == answer
                ? _value.answer
                : answer // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FaqItemImplCopyWith<$Res> implements $FaqItemCopyWith<$Res> {
  factory _$$FaqItemImplCopyWith(
    _$FaqItemImpl value,
    $Res Function(_$FaqItemImpl) then,
  ) = __$$FaqItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String question,
    String answer,
    String category,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$FaqItemImplCopyWithImpl<$Res>
    extends _$FaqItemCopyWithImpl<$Res, _$FaqItemImpl>
    implements _$$FaqItemImplCopyWith<$Res> {
  __$$FaqItemImplCopyWithImpl(
    _$FaqItemImpl _value,
    $Res Function(_$FaqItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FaqItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? question = null,
    Object? answer = null,
    Object? category = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(
      _$FaqItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        answer: null == answer
            ? _value.answer
            : answer // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FaqItemImpl implements _FaqItem {
  const _$FaqItemImpl({
    this.id,
    required this.question,
    required this.answer,
    this.category = 'geral',
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$FaqItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaqItemImplFromJson(json);

  @override
  final String? id;
  @override
  final String question;
  @override
  final String answer;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'FaqItem(id: $id, question: $question, answer: $answer, category: $category, sortOrder: $sortOrder, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaqItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    question,
    answer,
    category,
    sortOrder,
    isActive,
  );

  /// Create a copy of FaqItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FaqItemImplCopyWith<_$FaqItemImpl> get copyWith =>
      __$$FaqItemImplCopyWithImpl<_$FaqItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FaqItemImplToJson(this);
  }
}

abstract class _FaqItem implements FaqItem {
  const factory _FaqItem({
    final String? id,
    required final String question,
    required final String answer,
    final String category,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$FaqItemImpl;

  factory _FaqItem.fromJson(Map<String, dynamic> json) = _$FaqItemImpl.fromJson;

  @override
  String? get id;
  @override
  String get question;
  @override
  String get answer;
  @override
  String get category;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of FaqItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaqItemImplCopyWith<_$FaqItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CommentItem _$CommentItemFromJson(Map<String, dynamic> json) {
  return _CommentItem.fromJson(json);
}

/// @nodoc
mixin _$CommentItem {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_type')
  String get targetType => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_id')
  String get targetId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_id')
  String? get parentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_approved')
  bool get isApproved => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_name')
  String? get authorName => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_avatar')
  String? get authorAvatar => throw _privateConstructorUsedError;

  /// Serializes this CommentItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommentItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentItemCopyWith<CommentItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentItemCopyWith<$Res> {
  factory $CommentItemCopyWith(
    CommentItem value,
    $Res Function(CommentItem) then,
  ) = _$CommentItemCopyWithImpl<$Res, CommentItem>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'full_name') String fullName,
    @JsonKey(name: 'target_type') String targetType,
    @JsonKey(name: 'target_id') String targetId,
    String content,
    @JsonKey(name: 'parent_id') String? parentId,
    @JsonKey(name: 'is_approved') bool isApproved,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'author_name') String? authorName,
    @JsonKey(name: 'author_avatar') String? authorAvatar,
  });
}

/// @nodoc
class _$CommentItemCopyWithImpl<$Res, $Val extends CommentItem>
    implements $CommentItemCopyWith<$Res> {
  _$CommentItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? fullName = null,
    Object? targetType = null,
    Object? targetId = null,
    Object? content = null,
    Object? parentId = freezed,
    Object? isApproved = null,
    Object? createdAt = freezed,
    Object? authorName = freezed,
    Object? authorAvatar = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            targetType: null == targetType
                ? _value.targetType
                : targetType // ignore: cast_nullable_to_non_nullable
                      as String,
            targetId: null == targetId
                ? _value.targetId
                : targetId // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            parentId: freezed == parentId
                ? _value.parentId
                : parentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            isApproved: null == isApproved
                ? _value.isApproved
                : isApproved // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            authorName: freezed == authorName
                ? _value.authorName
                : authorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            authorAvatar: freezed == authorAvatar
                ? _value.authorAvatar
                : authorAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommentItemImplCopyWith<$Res>
    implements $CommentItemCopyWith<$Res> {
  factory _$$CommentItemImplCopyWith(
    _$CommentItemImpl value,
    $Res Function(_$CommentItemImpl) then,
  ) = __$$CommentItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'full_name') String fullName,
    @JsonKey(name: 'target_type') String targetType,
    @JsonKey(name: 'target_id') String targetId,
    String content,
    @JsonKey(name: 'parent_id') String? parentId,
    @JsonKey(name: 'is_approved') bool isApproved,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'author_name') String? authorName,
    @JsonKey(name: 'author_avatar') String? authorAvatar,
  });
}

/// @nodoc
class __$$CommentItemImplCopyWithImpl<$Res>
    extends _$CommentItemCopyWithImpl<$Res, _$CommentItemImpl>
    implements _$$CommentItemImplCopyWith<$Res> {
  __$$CommentItemImplCopyWithImpl(
    _$CommentItemImpl _value,
    $Res Function(_$CommentItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? fullName = null,
    Object? targetType = null,
    Object? targetId = null,
    Object? content = null,
    Object? parentId = freezed,
    Object? isApproved = null,
    Object? createdAt = freezed,
    Object? authorName = freezed,
    Object? authorAvatar = freezed,
  }) {
    return _then(
      _$CommentItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        targetType: null == targetType
            ? _value.targetType
            : targetType // ignore: cast_nullable_to_non_nullable
                  as String,
        targetId: null == targetId
            ? _value.targetId
            : targetId // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        parentId: freezed == parentId
            ? _value.parentId
            : parentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isApproved: null == isApproved
            ? _value.isApproved
            : isApproved // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        authorName: freezed == authorName
            ? _value.authorName
            : authorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        authorAvatar: freezed == authorAvatar
            ? _value.authorAvatar
            : authorAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentItemImpl implements _CommentItem {
  const _$CommentItemImpl({
    this.id,
    @JsonKey(name: 'user_id') this.userId,
    @JsonKey(name: 'full_name') this.fullName = '',
    @JsonKey(name: 'target_type') required this.targetType,
    @JsonKey(name: 'target_id') required this.targetId,
    required this.content,
    @JsonKey(name: 'parent_id') this.parentId,
    @JsonKey(name: 'is_approved') this.isApproved = true,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'author_name') this.authorName,
    @JsonKey(name: 'author_avatar') this.authorAvatar,
  });

  factory _$CommentItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentItemImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey(name: 'target_type')
  final String targetType;
  @override
  @JsonKey(name: 'target_id')
  final String targetId;
  @override
  final String content;
  @override
  @JsonKey(name: 'parent_id')
  final String? parentId;
  @override
  @JsonKey(name: 'is_approved')
  final bool isApproved;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'author_name')
  final String? authorName;
  @override
  @JsonKey(name: 'author_avatar')
  final String? authorAvatar;

  @override
  String toString() {
    return 'CommentItem(id: $id, userId: $userId, fullName: $fullName, targetType: $targetType, targetId: $targetId, content: $content, parentId: $parentId, isApproved: $isApproved, createdAt: $createdAt, authorName: $authorName, authorAvatar: $authorAvatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.targetType, targetType) ||
                other.targetType == targetType) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.authorAvatar, authorAvatar) ||
                other.authorAvatar == authorAvatar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    fullName,
    targetType,
    targetId,
    content,
    parentId,
    isApproved,
    createdAt,
    authorName,
    authorAvatar,
  );

  /// Create a copy of CommentItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentItemImplCopyWith<_$CommentItemImpl> get copyWith =>
      __$$CommentItemImplCopyWithImpl<_$CommentItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentItemImplToJson(this);
  }
}

abstract class _CommentItem implements CommentItem {
  const factory _CommentItem({
    final String? id,
    @JsonKey(name: 'user_id') final String? userId,
    @JsonKey(name: 'full_name') final String fullName,
    @JsonKey(name: 'target_type') required final String targetType,
    @JsonKey(name: 'target_id') required final String targetId,
    required final String content,
    @JsonKey(name: 'parent_id') final String? parentId,
    @JsonKey(name: 'is_approved') final bool isApproved,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'author_name') final String? authorName,
    @JsonKey(name: 'author_avatar') final String? authorAvatar,
  }) = _$CommentItemImpl;

  factory _CommentItem.fromJson(Map<String, dynamic> json) =
      _$CommentItemImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  @JsonKey(name: 'target_type')
  String get targetType;
  @override
  @JsonKey(name: 'target_id')
  String get targetId;
  @override
  String get content;
  @override
  @JsonKey(name: 'parent_id')
  String? get parentId;
  @override
  @JsonKey(name: 'is_approved')
  bool get isApproved;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'author_name')
  String? get authorName;
  @override
  @JsonKey(name: 'author_avatar')
  String? get authorAvatar;

  /// Create a copy of CommentItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentItemImplCopyWith<_$CommentItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) {
  return _NotificationItem.fromJson(json);
}

/// @nodoc
mixin _$NotificationItem {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  String get channel => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_read')
  bool get isRead => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'sent_at')
  DateTime? get sentAt => throw _privateConstructorUsedError;

  /// Serializes this NotificationItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationItemCopyWith<NotificationItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationItemCopyWith<$Res> {
  factory $NotificationItemCopyWith(
    NotificationItem value,
    $Res Function(NotificationItem) then,
  ) = _$NotificationItemCopyWithImpl<$Res, NotificationItem>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'user_id') String? userId,
    String title,
    String body,
    Map<String, dynamic> data,
    String channel,
    String city,
    @JsonKey(name: 'is_read') bool isRead,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'sent_at') DateTime? sentAt,
  });
}

/// @nodoc
class _$NotificationItemCopyWithImpl<$Res, $Val extends NotificationItem>
    implements $NotificationItemCopyWith<$Res> {
  _$NotificationItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? title = null,
    Object? body = null,
    Object? data = null,
    Object? channel = null,
    Object? city = null,
    Object? isRead = null,
    Object? isActive = null,
    Object? sentAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            body: null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            channel: null == channel
                ? _value.channel
                : channel // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            sentAt: freezed == sentAt
                ? _value.sentAt
                : sentAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationItemImplCopyWith<$Res>
    implements $NotificationItemCopyWith<$Res> {
  factory _$$NotificationItemImplCopyWith(
    _$NotificationItemImpl value,
    $Res Function(_$NotificationItemImpl) then,
  ) = __$$NotificationItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'user_id') String? userId,
    String title,
    String body,
    Map<String, dynamic> data,
    String channel,
    String city,
    @JsonKey(name: 'is_read') bool isRead,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'sent_at') DateTime? sentAt,
  });
}

/// @nodoc
class __$$NotificationItemImplCopyWithImpl<$Res>
    extends _$NotificationItemCopyWithImpl<$Res, _$NotificationItemImpl>
    implements _$$NotificationItemImplCopyWith<$Res> {
  __$$NotificationItemImplCopyWithImpl(
    _$NotificationItemImpl _value,
    $Res Function(_$NotificationItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? title = null,
    Object? body = null,
    Object? data = null,
    Object? channel = null,
    Object? city = null,
    Object? isRead = null,
    Object? isActive = null,
    Object? sentAt = freezed,
  }) {
    return _then(
      _$NotificationItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        channel: null == channel
            ? _value.channel
            : channel // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        sentAt: freezed == sentAt
            ? _value.sentAt
            : sentAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationItemImpl implements _NotificationItem {
  const _$NotificationItemImpl({
    this.id,
    @JsonKey(name: 'user_id') this.userId,
    required this.title,
    this.body = '',
    final Map<String, dynamic> data = const {},
    this.channel = 'in_app',
    this.city = '',
    @JsonKey(name: 'is_read') this.isRead = false,
    @JsonKey(name: 'is_active') this.isActive = true,
    @JsonKey(name: 'sent_at') this.sentAt,
  }) : _data = data;

  factory _$NotificationItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationItemImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  final String title;
  @override
  @JsonKey()
  final String body;
  final Map<String, dynamic> _data;
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  @JsonKey()
  final String channel;
  @override
  @JsonKey()
  final String city;
  @override
  @JsonKey(name: 'is_read')
  final bool isRead;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'sent_at')
  final DateTime? sentAt;

  @override
  String toString() {
    return 'NotificationItem(id: $id, userId: $userId, title: $title, body: $body, data: $data, channel: $channel, city: $city, isRead: $isRead, isActive: $isActive, sentAt: $sentAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    title,
    body,
    const DeepCollectionEquality().hash(_data),
    channel,
    city,
    isRead,
    isActive,
    sentAt,
  );

  /// Create a copy of NotificationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationItemImplCopyWith<_$NotificationItemImpl> get copyWith =>
      __$$NotificationItemImplCopyWithImpl<_$NotificationItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationItemImplToJson(this);
  }
}

abstract class _NotificationItem implements NotificationItem {
  const factory _NotificationItem({
    final String? id,
    @JsonKey(name: 'user_id') final String? userId,
    required final String title,
    final String body,
    final Map<String, dynamic> data,
    final String channel,
    final String city,
    @JsonKey(name: 'is_read') final bool isRead,
    @JsonKey(name: 'is_active') final bool isActive,
    @JsonKey(name: 'sent_at') final DateTime? sentAt,
  }) = _$NotificationItemImpl;

  factory _NotificationItem.fromJson(Map<String, dynamic> json) =
      _$NotificationItemImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  String get title;
  @override
  String get body;
  @override
  Map<String, dynamic> get data;
  @override
  String get channel;
  @override
  String get city;
  @override
  @JsonKey(name: 'is_read')
  bool get isRead;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'sent_at')
  DateTime? get sentAt;

  /// Create a copy of NotificationItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationItemImplCopyWith<_$NotificationItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) {
  return _SearchResult.fromJson(json);
}

/// @nodoc
mixin _$SearchResult {
  @JsonKey(name: 'result_type')
  String get resultType => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'url_path')
  String get urlPath => throw _privateConstructorUsedError;

  /// Serializes this SearchResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchResultCopyWith<SearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchResultCopyWith<$Res> {
  factory $SearchResultCopyWith(
    SearchResult value,
    $Res Function(SearchResult) then,
  ) = _$SearchResultCopyWithImpl<$Res, SearchResult>;
  @useResult
  $Res call({
    @JsonKey(name: 'result_type') String resultType,
    String? id,
    String title,
    String subtitle,
    String category,
    @JsonKey(name: 'image_url') String imageUrl,
    String slug,
    @JsonKey(name: 'url_path') String urlPath,
  });
}

/// @nodoc
class _$SearchResultCopyWithImpl<$Res, $Val extends SearchResult>
    implements $SearchResultCopyWith<$Res> {
  _$SearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultType = null,
    Object? id = freezed,
    Object? title = null,
    Object? subtitle = null,
    Object? category = null,
    Object? imageUrl = null,
    Object? slug = null,
    Object? urlPath = null,
  }) {
    return _then(
      _value.copyWith(
            resultType: null == resultType
                ? _value.resultType
                : resultType // ignore: cast_nullable_to_non_nullable
                      as String,
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            urlPath: null == urlPath
                ? _value.urlPath
                : urlPath // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SearchResultImplCopyWith<$Res>
    implements $SearchResultCopyWith<$Res> {
  factory _$$SearchResultImplCopyWith(
    _$SearchResultImpl value,
    $Res Function(_$SearchResultImpl) then,
  ) = __$$SearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'result_type') String resultType,
    String? id,
    String title,
    String subtitle,
    String category,
    @JsonKey(name: 'image_url') String imageUrl,
    String slug,
    @JsonKey(name: 'url_path') String urlPath,
  });
}

/// @nodoc
class __$$SearchResultImplCopyWithImpl<$Res>
    extends _$SearchResultCopyWithImpl<$Res, _$SearchResultImpl>
    implements _$$SearchResultImplCopyWith<$Res> {
  __$$SearchResultImplCopyWithImpl(
    _$SearchResultImpl _value,
    $Res Function(_$SearchResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultType = null,
    Object? id = freezed,
    Object? title = null,
    Object? subtitle = null,
    Object? category = null,
    Object? imageUrl = null,
    Object? slug = null,
    Object? urlPath = null,
  }) {
    return _then(
      _$SearchResultImpl(
        resultType: null == resultType
            ? _value.resultType
            : resultType // ignore: cast_nullable_to_non_nullable
                  as String,
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        urlPath: null == urlPath
            ? _value.urlPath
            : urlPath // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchResultImpl implements _SearchResult {
  const _$SearchResultImpl({
    @JsonKey(name: 'result_type') required this.resultType,
    this.id,
    required this.title,
    this.subtitle = '',
    this.category = '',
    @JsonKey(name: 'image_url') this.imageUrl = '',
    this.slug = '',
    @JsonKey(name: 'url_path') this.urlPath = '',
  });

  factory _$SearchResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchResultImplFromJson(json);

  @override
  @JsonKey(name: 'result_type')
  final String resultType;
  @override
  final String? id;
  @override
  final String title;
  @override
  @JsonKey()
  final String subtitle;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey()
  final String slug;
  @override
  @JsonKey(name: 'url_path')
  final String urlPath;

  @override
  String toString() {
    return 'SearchResult(resultType: $resultType, id: $id, title: $title, subtitle: $subtitle, category: $category, imageUrl: $imageUrl, slug: $slug, urlPath: $urlPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResultImpl &&
            (identical(other.resultType, resultType) ||
                other.resultType == resultType) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.urlPath, urlPath) || other.urlPath == urlPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    resultType,
    id,
    title,
    subtitle,
    category,
    imageUrl,
    slug,
    urlPath,
  );

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResultImplCopyWith<_$SearchResultImpl> get copyWith =>
      __$$SearchResultImplCopyWithImpl<_$SearchResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchResultImplToJson(this);
  }
}

abstract class _SearchResult implements SearchResult {
  const factory _SearchResult({
    @JsonKey(name: 'result_type') required final String resultType,
    final String? id,
    required final String title,
    final String subtitle,
    final String category,
    @JsonKey(name: 'image_url') final String imageUrl,
    final String slug,
    @JsonKey(name: 'url_path') final String urlPath,
  }) = _$SearchResultImpl;

  factory _SearchResult.fromJson(Map<String, dynamic> json) =
      _$SearchResultImpl.fromJson;

  @override
  @JsonKey(name: 'result_type')
  String get resultType;
  @override
  String? get id;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get category;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  String get slug;
  @override
  @JsonKey(name: 'url_path')
  String get urlPath;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchResultImplCopyWith<_$SearchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
mixin _$Profile {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String get avatarUrl => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res, Profile>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'full_name') String fullName,
    String email,
    String phone,
    String city,
    String role,
    @JsonKey(name: 'avatar_url') String avatarUrl,
    String bio,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res, $Val extends Profile>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = null,
    Object? email = null,
    Object? phone = null,
    Object? city = null,
    Object? role = null,
    Object? avatarUrl = null,
    Object? bio = null,
    Object? isActive = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: null == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            bio: null == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileImplCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$ProfileImplCopyWith(
    _$ProfileImpl value,
    $Res Function(_$ProfileImpl) then,
  ) = __$$ProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'full_name') String fullName,
    String email,
    String phone,
    String city,
    String role,
    @JsonKey(name: 'avatar_url') String avatarUrl,
    String bio,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$ProfileImplCopyWithImpl<$Res>
    extends _$ProfileCopyWithImpl<$Res, _$ProfileImpl>
    implements _$$ProfileImplCopyWith<$Res> {
  __$$ProfileImplCopyWithImpl(
    _$ProfileImpl _value,
    $Res Function(_$ProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = null,
    Object? email = null,
    Object? phone = null,
    Object? city = null,
    Object? role = null,
    Object? avatarUrl = null,
    Object? bio = null,
    Object? isActive = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$ProfileImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: null == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        bio: null == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileImpl extends _Profile {
  const _$ProfileImpl({
    this.id,
    @JsonKey(name: 'full_name') this.fullName = '',
    this.email = '',
    this.phone = '',
    this.city = '',
    this.role = 'user',
    @JsonKey(name: 'avatar_url') this.avatarUrl = '',
    this.bio = '',
    @JsonKey(name: 'is_active') this.isActive = true,
    @JsonKey(name: 'created_at') this.createdAt,
  }) : super._();

  factory _$ProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey()
  final String city;
  @override
  @JsonKey()
  final String role;
  @override
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @override
  @JsonKey()
  final String bio;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Profile(id: $id, fullName: $fullName, email: $email, phone: $phone, city: $city, role: $role, avatarUrl: $avatarUrl, bio: $bio, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fullName,
    email,
    phone,
    city,
    role,
    avatarUrl,
    bio,
    isActive,
    createdAt,
  );

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      __$$ProfileImplCopyWithImpl<_$ProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileImplToJson(this);
  }
}

abstract class _Profile extends Profile {
  const factory _Profile({
    final String? id,
    @JsonKey(name: 'full_name') final String fullName,
    final String email,
    final String phone,
    final String city,
    final String role,
    @JsonKey(name: 'avatar_url') final String avatarUrl,
    final String bio,
    @JsonKey(name: 'is_active') final bool isActive,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$ProfileImpl;
  const _Profile._() : super._();

  factory _Profile.fromJson(Map<String, dynamic> json) = _$ProfileImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String get email;
  @override
  String get phone;
  @override
  String get city;
  @override
  String get role;
  @override
  @JsonKey(name: 'avatar_url')
  String get avatarUrl;
  @override
  String get bio;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardCounts _$DashboardCountsFromJson(Map<String, dynamic> json) {
  return _DashboardCounts.fromJson(json);
}

/// @nodoc
mixin _$DashboardCounts {
  @JsonKey(name: 'news_count')
  int get newsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_count')
  int get planCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'events_count')
  int get eventsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'cities_count')
  int get citiesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'videos_count')
  int get videosCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'gallery_count')
  int get galleryCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'volunteers_pending')
  int get volunteersPending => throw _privateConstructorUsedError;
  @JsonKey(name: 'messages_new')
  int get messagesNew => throw _privateConstructorUsedError;
  @JsonKey(name: 'reports_pending')
  int get reportsPending => throw _privateConstructorUsedError;
  @JsonKey(name: 'likes_count')
  int get likesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'comments_count')
  int get commentsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'profiles_count')
  int get profilesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'audit_count')
  int get auditCount => throw _privateConstructorUsedError;

  /// Serializes this DashboardCounts to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardCounts
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardCountsCopyWith<DashboardCounts> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardCountsCopyWith<$Res> {
  factory $DashboardCountsCopyWith(
    DashboardCounts value,
    $Res Function(DashboardCounts) then,
  ) = _$DashboardCountsCopyWithImpl<$Res, DashboardCounts>;
  @useResult
  $Res call({
    @JsonKey(name: 'news_count') int newsCount,
    @JsonKey(name: 'plan_count') int planCount,
    @JsonKey(name: 'events_count') int eventsCount,
    @JsonKey(name: 'cities_count') int citiesCount,
    @JsonKey(name: 'videos_count') int videosCount,
    @JsonKey(name: 'gallery_count') int galleryCount,
    @JsonKey(name: 'volunteers_pending') int volunteersPending,
    @JsonKey(name: 'messages_new') int messagesNew,
    @JsonKey(name: 'reports_pending') int reportsPending,
    @JsonKey(name: 'likes_count') int likesCount,
    @JsonKey(name: 'comments_count') int commentsCount,
    @JsonKey(name: 'profiles_count') int profilesCount,
    @JsonKey(name: 'audit_count') int auditCount,
  });
}

/// @nodoc
class _$DashboardCountsCopyWithImpl<$Res, $Val extends DashboardCounts>
    implements $DashboardCountsCopyWith<$Res> {
  _$DashboardCountsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardCounts
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newsCount = null,
    Object? planCount = null,
    Object? eventsCount = null,
    Object? citiesCount = null,
    Object? videosCount = null,
    Object? galleryCount = null,
    Object? volunteersPending = null,
    Object? messagesNew = null,
    Object? reportsPending = null,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? profilesCount = null,
    Object? auditCount = null,
  }) {
    return _then(
      _value.copyWith(
            newsCount: null == newsCount
                ? _value.newsCount
                : newsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            planCount: null == planCount
                ? _value.planCount
                : planCount // ignore: cast_nullable_to_non_nullable
                      as int,
            eventsCount: null == eventsCount
                ? _value.eventsCount
                : eventsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            citiesCount: null == citiesCount
                ? _value.citiesCount
                : citiesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            videosCount: null == videosCount
                ? _value.videosCount
                : videosCount // ignore: cast_nullable_to_non_nullable
                      as int,
            galleryCount: null == galleryCount
                ? _value.galleryCount
                : galleryCount // ignore: cast_nullable_to_non_nullable
                      as int,
            volunteersPending: null == volunteersPending
                ? _value.volunteersPending
                : volunteersPending // ignore: cast_nullable_to_non_nullable
                      as int,
            messagesNew: null == messagesNew
                ? _value.messagesNew
                : messagesNew // ignore: cast_nullable_to_non_nullable
                      as int,
            reportsPending: null == reportsPending
                ? _value.reportsPending
                : reportsPending // ignore: cast_nullable_to_non_nullable
                      as int,
            likesCount: null == likesCount
                ? _value.likesCount
                : likesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            commentsCount: null == commentsCount
                ? _value.commentsCount
                : commentsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            profilesCount: null == profilesCount
                ? _value.profilesCount
                : profilesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            auditCount: null == auditCount
                ? _value.auditCount
                : auditCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DashboardCountsImplCopyWith<$Res>
    implements $DashboardCountsCopyWith<$Res> {
  factory _$$DashboardCountsImplCopyWith(
    _$DashboardCountsImpl value,
    $Res Function(_$DashboardCountsImpl) then,
  ) = __$$DashboardCountsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'news_count') int newsCount,
    @JsonKey(name: 'plan_count') int planCount,
    @JsonKey(name: 'events_count') int eventsCount,
    @JsonKey(name: 'cities_count') int citiesCount,
    @JsonKey(name: 'videos_count') int videosCount,
    @JsonKey(name: 'gallery_count') int galleryCount,
    @JsonKey(name: 'volunteers_pending') int volunteersPending,
    @JsonKey(name: 'messages_new') int messagesNew,
    @JsonKey(name: 'reports_pending') int reportsPending,
    @JsonKey(name: 'likes_count') int likesCount,
    @JsonKey(name: 'comments_count') int commentsCount,
    @JsonKey(name: 'profiles_count') int profilesCount,
    @JsonKey(name: 'audit_count') int auditCount,
  });
}

/// @nodoc
class __$$DashboardCountsImplCopyWithImpl<$Res>
    extends _$DashboardCountsCopyWithImpl<$Res, _$DashboardCountsImpl>
    implements _$$DashboardCountsImplCopyWith<$Res> {
  __$$DashboardCountsImplCopyWithImpl(
    _$DashboardCountsImpl _value,
    $Res Function(_$DashboardCountsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardCounts
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newsCount = null,
    Object? planCount = null,
    Object? eventsCount = null,
    Object? citiesCount = null,
    Object? videosCount = null,
    Object? galleryCount = null,
    Object? volunteersPending = null,
    Object? messagesNew = null,
    Object? reportsPending = null,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? profilesCount = null,
    Object? auditCount = null,
  }) {
    return _then(
      _$DashboardCountsImpl(
        newsCount: null == newsCount
            ? _value.newsCount
            : newsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        planCount: null == planCount
            ? _value.planCount
            : planCount // ignore: cast_nullable_to_non_nullable
                  as int,
        eventsCount: null == eventsCount
            ? _value.eventsCount
            : eventsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        citiesCount: null == citiesCount
            ? _value.citiesCount
            : citiesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        videosCount: null == videosCount
            ? _value.videosCount
            : videosCount // ignore: cast_nullable_to_non_nullable
                  as int,
        galleryCount: null == galleryCount
            ? _value.galleryCount
            : galleryCount // ignore: cast_nullable_to_non_nullable
                  as int,
        volunteersPending: null == volunteersPending
            ? _value.volunteersPending
            : volunteersPending // ignore: cast_nullable_to_non_nullable
                  as int,
        messagesNew: null == messagesNew
            ? _value.messagesNew
            : messagesNew // ignore: cast_nullable_to_non_nullable
                  as int,
        reportsPending: null == reportsPending
            ? _value.reportsPending
            : reportsPending // ignore: cast_nullable_to_non_nullable
                  as int,
        likesCount: null == likesCount
            ? _value.likesCount
            : likesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        commentsCount: null == commentsCount
            ? _value.commentsCount
            : commentsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        profilesCount: null == profilesCount
            ? _value.profilesCount
            : profilesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        auditCount: null == auditCount
            ? _value.auditCount
            : auditCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardCountsImpl implements _DashboardCounts {
  const _$DashboardCountsImpl({
    @JsonKey(name: 'news_count') this.newsCount = 0,
    @JsonKey(name: 'plan_count') this.planCount = 0,
    @JsonKey(name: 'events_count') this.eventsCount = 0,
    @JsonKey(name: 'cities_count') this.citiesCount = 0,
    @JsonKey(name: 'videos_count') this.videosCount = 0,
    @JsonKey(name: 'gallery_count') this.galleryCount = 0,
    @JsonKey(name: 'volunteers_pending') this.volunteersPending = 0,
    @JsonKey(name: 'messages_new') this.messagesNew = 0,
    @JsonKey(name: 'reports_pending') this.reportsPending = 0,
    @JsonKey(name: 'likes_count') this.likesCount = 0,
    @JsonKey(name: 'comments_count') this.commentsCount = 0,
    @JsonKey(name: 'profiles_count') this.profilesCount = 0,
    @JsonKey(name: 'audit_count') this.auditCount = 0,
  });

  factory _$DashboardCountsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardCountsImplFromJson(json);

  @override
  @JsonKey(name: 'news_count')
  final int newsCount;
  @override
  @JsonKey(name: 'plan_count')
  final int planCount;
  @override
  @JsonKey(name: 'events_count')
  final int eventsCount;
  @override
  @JsonKey(name: 'cities_count')
  final int citiesCount;
  @override
  @JsonKey(name: 'videos_count')
  final int videosCount;
  @override
  @JsonKey(name: 'gallery_count')
  final int galleryCount;
  @override
  @JsonKey(name: 'volunteers_pending')
  final int volunteersPending;
  @override
  @JsonKey(name: 'messages_new')
  final int messagesNew;
  @override
  @JsonKey(name: 'reports_pending')
  final int reportsPending;
  @override
  @JsonKey(name: 'likes_count')
  final int likesCount;
  @override
  @JsonKey(name: 'comments_count')
  final int commentsCount;
  @override
  @JsonKey(name: 'profiles_count')
  final int profilesCount;
  @override
  @JsonKey(name: 'audit_count')
  final int auditCount;

  @override
  String toString() {
    return 'DashboardCounts(newsCount: $newsCount, planCount: $planCount, eventsCount: $eventsCount, citiesCount: $citiesCount, videosCount: $videosCount, galleryCount: $galleryCount, volunteersPending: $volunteersPending, messagesNew: $messagesNew, reportsPending: $reportsPending, likesCount: $likesCount, commentsCount: $commentsCount, profilesCount: $profilesCount, auditCount: $auditCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardCountsImpl &&
            (identical(other.newsCount, newsCount) ||
                other.newsCount == newsCount) &&
            (identical(other.planCount, planCount) ||
                other.planCount == planCount) &&
            (identical(other.eventsCount, eventsCount) ||
                other.eventsCount == eventsCount) &&
            (identical(other.citiesCount, citiesCount) ||
                other.citiesCount == citiesCount) &&
            (identical(other.videosCount, videosCount) ||
                other.videosCount == videosCount) &&
            (identical(other.galleryCount, galleryCount) ||
                other.galleryCount == galleryCount) &&
            (identical(other.volunteersPending, volunteersPending) ||
                other.volunteersPending == volunteersPending) &&
            (identical(other.messagesNew, messagesNew) ||
                other.messagesNew == messagesNew) &&
            (identical(other.reportsPending, reportsPending) ||
                other.reportsPending == reportsPending) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            (identical(other.profilesCount, profilesCount) ||
                other.profilesCount == profilesCount) &&
            (identical(other.auditCount, auditCount) ||
                other.auditCount == auditCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    newsCount,
    planCount,
    eventsCount,
    citiesCount,
    videosCount,
    galleryCount,
    volunteersPending,
    messagesNew,
    reportsPending,
    likesCount,
    commentsCount,
    profilesCount,
    auditCount,
  );

  /// Create a copy of DashboardCounts
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardCountsImplCopyWith<_$DashboardCountsImpl> get copyWith =>
      __$$DashboardCountsImplCopyWithImpl<_$DashboardCountsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardCountsImplToJson(this);
  }
}

abstract class _DashboardCounts implements DashboardCounts {
  const factory _DashboardCounts({
    @JsonKey(name: 'news_count') final int newsCount,
    @JsonKey(name: 'plan_count') final int planCount,
    @JsonKey(name: 'events_count') final int eventsCount,
    @JsonKey(name: 'cities_count') final int citiesCount,
    @JsonKey(name: 'videos_count') final int videosCount,
    @JsonKey(name: 'gallery_count') final int galleryCount,
    @JsonKey(name: 'volunteers_pending') final int volunteersPending,
    @JsonKey(name: 'messages_new') final int messagesNew,
    @JsonKey(name: 'reports_pending') final int reportsPending,
    @JsonKey(name: 'likes_count') final int likesCount,
    @JsonKey(name: 'comments_count') final int commentsCount,
    @JsonKey(name: 'profiles_count') final int profilesCount,
    @JsonKey(name: 'audit_count') final int auditCount,
  }) = _$DashboardCountsImpl;

  factory _DashboardCounts.fromJson(Map<String, dynamic> json) =
      _$DashboardCountsImpl.fromJson;

  @override
  @JsonKey(name: 'news_count')
  int get newsCount;
  @override
  @JsonKey(name: 'plan_count')
  int get planCount;
  @override
  @JsonKey(name: 'events_count')
  int get eventsCount;
  @override
  @JsonKey(name: 'cities_count')
  int get citiesCount;
  @override
  @JsonKey(name: 'videos_count')
  int get videosCount;
  @override
  @JsonKey(name: 'gallery_count')
  int get galleryCount;
  @override
  @JsonKey(name: 'volunteers_pending')
  int get volunteersPending;
  @override
  @JsonKey(name: 'messages_new')
  int get messagesNew;
  @override
  @JsonKey(name: 'reports_pending')
  int get reportsPending;
  @override
  @JsonKey(name: 'likes_count')
  int get likesCount;
  @override
  @JsonKey(name: 'comments_count')
  int get commentsCount;
  @override
  @JsonKey(name: 'profiles_count')
  int get profilesCount;
  @override
  @JsonKey(name: 'audit_count')
  int get auditCount;

  /// Create a copy of DashboardCounts
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardCountsImplCopyWith<_$DashboardCountsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BiographyItem _$BiographyItemFromJson(Map<String, dynamic> json) {
  return _BiographyItem.fromJson(json);
}

/// @nodoc
mixin _$BiographyItem {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_type')
  String get itemType => throw _privateConstructorUsedError;
  String get year => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this BiographyItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BiographyItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BiographyItemCopyWith<BiographyItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BiographyItemCopyWith<$Res> {
  factory $BiographyItemCopyWith(
    BiographyItem value,
    $Res Function(BiographyItem) then,
  ) = _$BiographyItemCopyWithImpl<$Res, BiographyItem>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'item_type') String itemType,
    String year,
    String title,
    String text,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$BiographyItemCopyWithImpl<$Res, $Val extends BiographyItem>
    implements $BiographyItemCopyWith<$Res> {
  _$BiographyItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BiographyItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? itemType = null,
    Object? year = null,
    Object? title = null,
    Object? text = null,
    Object? imageUrl = null,
    Object? sortOrder = null,
    Object? isActive = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            itemType: null == itemType
                ? _value.itemType
                : itemType // ignore: cast_nullable_to_non_nullable
                      as String,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BiographyItemImplCopyWith<$Res>
    implements $BiographyItemCopyWith<$Res> {
  factory _$$BiographyItemImplCopyWith(
    _$BiographyItemImpl value,
    $Res Function(_$BiographyItemImpl) then,
  ) = __$$BiographyItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'item_type') String itemType,
    String year,
    String title,
    String text,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$BiographyItemImplCopyWithImpl<$Res>
    extends _$BiographyItemCopyWithImpl<$Res, _$BiographyItemImpl>
    implements _$$BiographyItemImplCopyWith<$Res> {
  __$$BiographyItemImplCopyWithImpl(
    _$BiographyItemImpl _value,
    $Res Function(_$BiographyItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BiographyItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? itemType = null,
    Object? year = null,
    Object? title = null,
    Object? text = null,
    Object? imageUrl = null,
    Object? sortOrder = null,
    Object? isActive = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$BiographyItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        itemType: null == itemType
            ? _value.itemType
            : itemType // ignore: cast_nullable_to_non_nullable
                  as String,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BiographyItemImpl implements _BiographyItem {
  const _$BiographyItemImpl({
    this.id,
    @JsonKey(name: 'item_type') this.itemType = 'historia',
    this.year = '',
    required this.title,
    this.text = '',
    @JsonKey(name: 'image_url') this.imageUrl = '',
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'is_active') this.isActive = true,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$BiographyItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$BiographyItemImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'item_type')
  final String itemType;
  @override
  @JsonKey()
  final String year;
  @override
  final String title;
  @override
  @JsonKey()
  final String text;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'BiographyItem(id: $id, itemType: $itemType, year: $year, title: $title, text: $text, imageUrl: $imageUrl, sortOrder: $sortOrder, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BiographyItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.itemType, itemType) ||
                other.itemType == itemType) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    itemType,
    year,
    title,
    text,
    imageUrl,
    sortOrder,
    isActive,
    createdAt,
  );

  /// Create a copy of BiographyItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BiographyItemImplCopyWith<_$BiographyItemImpl> get copyWith =>
      __$$BiographyItemImplCopyWithImpl<_$BiographyItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BiographyItemImplToJson(this);
  }
}

abstract class _BiographyItem implements BiographyItem {
  const factory _BiographyItem({
    final String? id,
    @JsonKey(name: 'item_type') final String itemType,
    final String year,
    required final String title,
    final String text,
    @JsonKey(name: 'image_url') final String imageUrl,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'is_active') final bool isActive,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$BiographyItemImpl;

  factory _BiographyItem.fromJson(Map<String, dynamic> json) =
      _$BiographyItemImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'item_type')
  String get itemType;
  @override
  String get year;
  @override
  String get title;
  @override
  String get text;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of BiographyItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BiographyItemImplCopyWith<_$BiographyItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
