package Portfolio.My.domain;

import org.springframework.web.util.UriComponentsBuilder;

import static java.lang.Math.*;
import static java.util.Objects.requireNonNullElse;

public class SearchCondition {
    private Integer page = 1;
    private Integer pageSize = DEFAULT_PAGE_SIZE;
    private String  option = "";
    private String  keyword = "";
//    private Integer  offset;  딱히 필요가 없다. 왜냐하면 page와 pageSize값으로 결정되는 값이기 때문이다.

    public static final int MIN_PAGE_SIZE = 5;
    public static final int DEFAULT_PAGE_SIZE = 10;
    public static final int MAX_PAGE_SIZE = 50;

    public SearchCondition(){}

    public SearchCondition(Integer page, Integer pageSize) {
        this(page, pageSize, "", "");
    }

    public SearchCondition(Integer page, Integer pageSize, String option, String keyword) {
        this.page = page;
        this.pageSize = pageSize;
        this.option = option;
        this.keyword = keyword;
    }

    public String getQueryString() {
        return getQueryString(page);
    }

    public String getQueryString(Integer page) {
        // ?page=10&pageSize=10&option=A&keyword=title  아래가 하는 일이 이렇게 만들어 주는 역할을 한다.
        return UriComponentsBuilder.newInstance()
                .queryParam("page",     page)
                .queryParam("pageSize", pageSize)
                .queryParam("option",   option)
                .queryParam("keyword",  keyword)
                .build().toString();
    }
    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = requireNonNullElse(pageSize, DEFAULT_PAGE_SIZE);

        // MIN_PAGE_SIZE <= pageSize <= MAX_PAGE_SIZE
        this.pageSize = max(MIN_PAGE_SIZE, min(this.pageSize, MAX_PAGE_SIZE));
    }

    public String getOption() {
        return option;
    }

    public void setOption(String option) {
        this.option = option;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public Integer getOffset() {
        return (page-1)*pageSize;
    }

    @Override
    public String toString() {
        return "SearchCondition{" +
                "page=" + page +
                ", pageSize=" + pageSize +
                ", option='" + option + '\'' +
                ", keyword='" + keyword + '\'' +
                '}';
    }
}