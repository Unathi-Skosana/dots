local status_ok, comment = pcall(require, 'Comment')
if not status_ok then
  return
end

local status_ok, comment_utils = pcall(require, 'Comment.utils')
if not status_ok then
  return
end


local status_ok, commentstring_utils = pcall(require, 'ts_context_commentstring.utils')
if not status_ok then
  return
end


local status_ok, commentstring_internal = pcall(require, 'ts_context_commentstring.internal')
if not status_ok then
  return
end

comment.setup({
	pre_hook = function(ctx)
		local U = comment_utils

		local location = nil
		if ctx.ctype == U.ctype.block then
			location = commentstring_utils.get_cursor_location()
		elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
			location = commentstring_utils.get_visual_start_location()
		end

		return commentstring_internal.calculate_commentstring({
			key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
			location = location,
		})
	end,
})