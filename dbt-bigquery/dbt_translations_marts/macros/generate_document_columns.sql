{% macro generate_doc_name_columns(max_docs) %}
    {%- for i in range(1, max_docs + 1) %}
        SPLIT(doc_names, ' + ')[SAFE_OFFSET({{ i-1 }})] AS doc_name_{{ i }}{% if not loop.last %},{% endif %}
    {%- endfor %}
{% endmacro %}


{% macro generate_doc_name_columns_from_array(array_col, max_docs) %}
    {%- for i in range(1, max_docs + 1) %}
        {{ array_col }}[SAFE_OFFSET({{ i-1 }})] AS doc_name_{{ i }}
        {% if not loop.last %},{% endif %}
    {%- endfor %}
{% endmacro %}


{% macro generate_doc_struct_columns(max_docs) %}
    {%- for i in range(1, max_docs + 1) %}
        documents[SAFE_OFFSET({{ i - 1 }})].document_name AS doc_name_{{ i }},
        documents[SAFE_OFFSET({{ i - 1 }})].standardized_name AS standardized_name_{{ i }},
        documents[SAFE_OFFSET({{ i - 1 }})].price AS price_{{ i }},
        documents[SAFE_OFFSET({{ i - 1 }})].language AS language_{{ i }},
        documents[SAFE_OFFSET({{ i - 1 }})].nb_copies AS nb_copies_{{ i }}
        {% if not loop.last %},{% endif %}
    {%- endfor %}
{% endmacro %}
