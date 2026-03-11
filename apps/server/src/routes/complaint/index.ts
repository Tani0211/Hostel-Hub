export default async function complaintRoutes(fastify: any) {
    fastify.post('/complaint', async (request: any, response: any) => {
        //   title, details, category, urgency_level, image
        const { title, details, category, urgency_level, image } = request.body;
        const complaint = await fastify.db.complaint.create({
            data: {
                title,
                details,
                category,
                urgency_level,
                image
            }
        });
        return response.code(201).send({ success: true, ...complaint, message: "Complaint Created Successfully" });
    })
}