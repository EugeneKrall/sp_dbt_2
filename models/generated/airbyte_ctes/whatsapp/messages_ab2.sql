{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_whatsapp",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('messages_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(text as {{ dbt_utils.type_string() }}) as text,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(price as {{ dbt_utils.type_float() }}) as price,
    cast(bot_id as {{ dbt_utils.type_string() }}) as bot_id,
    cast(status as {{ dbt_utils.type_float() }}) as status,
    {{ cast_to_boolean('is_paid') }} as is_paid,
    cast(user_id as {{ dbt_utils.type_float() }}) as user_id,
    cast(campaign as {{ dbt_utils.type_string() }}) as campaign,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(direction as {{ dbt_utils.type_float() }}) as direction,
    cast(contact_id as {{ dbt_utils.type_string() }}) as contact_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(channel_data as {{ dbt_utils.type_string() }}) as channel_data,
    cast(reject_reason as {{ dbt_utils.type_string() }}) as reject_reason,
    cast(price_country_code as {{ dbt_utils.type_string() }}) as price_country_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('messages_ab1') }}
-- messages
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

