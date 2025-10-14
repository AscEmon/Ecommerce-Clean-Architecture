class GlobalPaginator {
  GlobalPaginator({
    this.currentPage,
    this.totalPages,
    this.recordPerPage,
  });

  int? currentPage;
  int? totalPages;
  int? recordPerPage;

  factory GlobalPaginator.fromJson(Map<String, dynamic> json) =>
      GlobalPaginator(
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        recordPerPage:
            json["record_per_page"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "total_pages": totalPages,
        "record_per_page": recordPerPage,
      };
    }