const { createClient } = require('@supabase/supabase-js');

exports.handler = async function(event, context) {
    try {
        // Initialize Supabase client
        const supabase = createClient(
            process.env.SUPABASE_URL,
            process.env.SUPABASE_ANON_KEY
        );

        // Test database connection
        const { data: testData, error: testError } = await supabase
            .from('competitions')
            .select('id')
            .limit(1);

        if (testError) {
            throw new Error(`Database connection test failed: ${testError.message}`);
        }

        // Test styling options by creating a test competition
        const testCompetition = {
            title: 'Test Competition',
            summary: 'This is a test competition',
            category: 'general',
            question: 'What is 2+2?',
            ending_date: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toISOString(),
            ticket_price: 1.00,
            available_tickets: 100,
            max_tickets_per_email: 5,
            min_tickets_sold: 10,
            body_color: '#ffffff',
            panel_color: '#f3f4f6',
            highlight_color: '#3b82f6',
            text_color: '#1f2937',
            created_at: new Date().toISOString(),
            updated_at: new Date().toISOString()
        };

        const { data: insertedData, error: insertError } = await supabase
            .from('competitions')
            .insert([testCompetition])
            .select();

        if (insertError) {
            throw new Error(`Test data insertion failed: ${insertError.message}`);
        }

        // Clean up test data
        if (insertedData && insertedData.length > 0) {
            await supabase
                .from('competitions')
                .delete()
                .eq('id', insertedData[0].id);
        }

        return {
            statusCode: 200,
            body: JSON.stringify({
                success: true,
                message: 'Database connection and styling options test successful',
                testData: {
                    connection: 'OK',
                    styling: {
                        body_color: testCompetition.body_color,
                        panel_color: testCompetition.panel_color,
                        highlight_color: testCompetition.highlight_color,
                        text_color: testCompetition.text_color
                    }
                }
            })
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({
                success: false,
                error: error.message
            })
        };
    }
}; 