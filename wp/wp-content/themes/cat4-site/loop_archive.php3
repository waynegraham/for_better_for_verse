<div class="entry">
<dl class="media">
	<dt><?php if(in_category('6')) : ?>Term<?php else: ?>Title<?php endif; ?>:</dt>
	<dd><h4><?php the_title(); ?></h4></dd>

<?php if($poem_author) : ?>
	<dt>Author:</dt>
	<dd><p><?php echo $poem_author; ?></p></dd>
<?php endif; ?>

<?php if (is_category() || is_search() ) : ?>

<?php elseif (in_category('3')) : ?>
	<dt>Type:</dt>
	<dd><p><?php the_category(', ') ?></p></dd>
<?php endif; ?>
	
<?php if(in_category('3')) : ?>
	<dt>Application:</dt>
	<dd><p><a href="<?php the_permalink() ?>" rel="bookmark">Try your hand at "<?php the_title(); ?>"?</a></p></dd>
<?php else : ?>
	<?php if (!in_category('6')) : ?>
		<?php the_tags( '<dt>Related Poems:</dt><dd><p> ', ', ', '</p></dd>'); ?>
	<?php endif; ?>
	<dt>Information:</dt>
	<dd><?php the_content(); ?></dd>
<?php endif; ?>
	
</dl>
</div>