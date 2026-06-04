-- reading-stats.lua
-- injects reading-time bar after the title block
-- only runs when reading-meta-enabled: true is set in metadata
-- skips listing pages (doc.meta.listing present)
-- excludes CodeBlock and inline Code from word/char counts

function Pandoc(doc)

    if not doc.meta['reading-meta-enabled'] then return doc end
    if doc.meta.listing then return doc end

    --------------------------------------------------
    -- Strip code before counting
    --------------------------------------------------

    local stripped = doc:walk({
        CodeBlock = function() return {} end,
        RawBlock  = function() return {} end,
        Code      = function() return pandoc.Str("") end,
        RawInline = function() return pandoc.Str("") end,
    })

    local text = pandoc.utils.stringify(stripped)

    --------------------------------------------------
    -- English words
    --------------------------------------------------

    local en_words = 0

    for _ in text:gmatch("[%a%d][%w%-']*") do
    en_words = en_words + 1
    end

    --------------------------------------------------
    -- Chinese chars
    --------------------------------------------------

    local zh_chars = 0

    for _ in text:gmatch("[\228-\233][\128-\191][\128-\191]") do
    zh_chars = zh_chars + 1
    end

    --------------------------------------------------
    -- Estimate reading time
    --
    -- English: 200 wpm
    -- Chinese: 300 chars/min
    --------------------------------------------------

    local minutes =
        math.ceil(
            (en_words / 200) +
            (zh_chars / 300)
        )

    if minutes < 1 then
        minutes = 1
    end

    --------------------------------------------------
    -- Inject HTML block at start of document body
    -- (renders after Quarto's title/author/date block)
    --------------------------------------------------

    local clock_svg = [[
        <svg xmlns="http://www.w3.org/2000/svg"
                width="12" height="12"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                style="vertical-align:-1px;">
            <circle cx="12" cy="12" r="10"/>
            <path d="M12 6v6l4 2"/>
        </svg>
    ]]

    local html =
        '<div class="reading-meta">' ..
        '<span>' .. clock_svg .. ' ' .. minutes .. ' min read</span>' ..
        '<span> · </span>' ..
        '<span>' .. en_words .. ' EN words</span>' ..
        '<span> · </span>' ..
        '<span>' .. zh_chars .. ' 中文字</span>' ..
        '</div>'

    table.insert(doc.blocks, 1, pandoc.RawBlock('html', html))

    return doc

end
